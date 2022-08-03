import os
import re
from unicodedata import category
import yaml
import hashlib

import click
import rich
from rich.console import Console
from rich.table import Table, box
from rich.progress import track, Progress, BarColumn, TextColumn
import sqlparse

from dbmt.mysql import (
    connect_to_mysql,
    mysql_execute,
    mysql_cursor_fetchone,
    mysql_cursor_fetchall,
)


VERBOSE = False
CHECK_VARIABLES = False
CONFIG = {}


def print_error(err):
    rich.print(f"[red]Error: {err}")


def replace_with_os_env(row: str, error_place="config file"):
    error = False
    if row.lstrip()[0] != "#":
        result = re.findall("<(\\w+)>", row)
        for var in result:
            osenv = os.getenv(var)
            if not osenv:
                if CHECK_VARIABLES:
                    print_error(
                        f"Environment variable [bold]'{var}'[/bold] "
                        f"is missing/empty in {error_place}[/red]"
                    )
                    error = True
            else:
                row = row.replace(f"<{var}>", osenv)
    return row, error


def load_config_file(config_file):
    global CONFIG

    if VERBOSE:
        rich.print(f"Reading config file: {config_file}...")

    if not os.path.exists(config_file):
        print_error(f"Config file {config_file} not found.")
        exit(1)

    with open(config_file, "r") as stream:
        stream = stream.readlines()
        data = ""
        for row in stream:
            row, _ = replace_with_os_env(row)
            data = data + row + "\n"
        try:
            CONFIG = yaml.safe_load(data)
            if VERBOSE:
                rich.print(CONFIG)
        except yaml.YAMLError as exc:
            print(exc)

    if VERBOSE:
        rich.print("...Done!")


def connect_to_db():
    cnx = connect_to_mysql(
        user=CONFIG["database"]["username"],
        password=CONFIG["database"]["password"],
        host=CONFIG["database"]["host"],
        database=CONFIG["database"]["database"],
    )
    return cnx


def add_schema_histort_table(cnx):
    sql = (
        "CREATE TABLE if not exists `dbmt_schema_history` ("
        "`id` INT NOT NULL AUTO_INCREMENT , "
        "`version` VARCHAR(10) NOT NULL , "
        "`description` VARCHAR(255) NOT NULL , "
        "`script` VARCHAR(255) NOT NULL , "
        "`checksum` VARCHAR(64) NOT NULL , "
        "`installed_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , "
        "`success` INT NOT NULL, "
        "PRIMARY KEY (`id`) "
        ") ENGINE = InnoDB;"
    )
    mysql_execute(cnx, sql)


def get_version(filename: str):
    version = filename.split("__")[0][1:]
    version = version.replace("_", ".")
    return version


def get_description(filename):
    description = str(filename.split("__")[1][:-4])
    description = description.replace("_", " ")
    description = description.capitalize()
    return description


def progress_bar_settings():
    text_column = TextColumn("{task.description}")
    bar_column = BarColumn(bar_width=50)
    progress = Progress(bar_column, text_column)
    return progress


def migrate_database():
    cnx = connect_to_db()
    add_schema_histort_table(cnx)
    files = os.listdir("sql")
    files = sorted(files)
    for file in files:
        version = get_version(file)
        description = get_description(file)
        # print(version, description, file)
        sql = f"SELECT * FROM dbmt_schema_history WHERE script='{file}' ORDER BY id DESC LIMIT 1;"
        cursor = mysql_execute(cnx, sql)
        schema_history_data = mysql_cursor_fetchone(cursor)
        if schema_history_data and (
            hashlib.sha256(open(os.path.join("sql", file), "rb").read()).hexdigest()
            != schema_history_data["checksum"]
        ):
            print_error(f"{file} has been changed since migration.")
            exit(1)
        if not schema_history_data:
            with open(os.path.join("sql", file), "r") as stream:
                sql = stream.read()
                sql_queries = sqlparse.split(sql)
                progress = progress_bar_settings()
                with progress:
                    for row in progress.track(
                        sql_queries, description=f"Migrating {file}"
                    ):
                        mysql_execute(cnx, row)
                sha256 = hashlib.sha256(sql.encode()).hexdigest()
                sql = (
                    "INSERT INTO dbmt_schema_history (version, description, script, success, checksum) "
                    f"VALUES ('{version}','{description}','{file}','1','{sha256}')"
                )
                mysql_execute(cnx, sql)
                cnx.commit()


def clean_database():
    cnx = connect_to_db()
    sql = (
        "SELECT CONCAT('DROP TABLE IF EXISTS `', table_name, '`;') query "
        "FROM information_schema.tables "
        f"WHERE table_schema = '{CONFIG['database']['database']}';"
    )
    cursor = mysql_execute(cnx, sql)
    data = mysql_cursor_fetchall(cursor)
    progress = progress_bar_settings()
    with progress:
        for row in progress.track(data, description="Cleaning database"):
            mysql_execute(cnx, row["query"])


def get_files():
    files = os.listdir("sql")
    files = sorted(files)
    return_files = []
    for file in files:
        version = get_version(file)
        description = get_description(file)
        return_files.append(
            {"filename": file, "description": description, "version": version}
        )
    return return_files


def get_version_info(version, schema_history_data):
    for row in schema_history_data:
        if row["version"] == version:
            return row
    return {}


def database_info():
    cnx = connect_to_db()
    sql = f"SELECT * FROM dbmt_schema_history ORDER BY id"
    cursor = mysql_execute(cnx, sql)
    schema_history_data = mysql_cursor_fetchall(cursor)
    files = get_files()
    table_data = []
    for row in files:
        version = row["version"]
        description = row["description"]
        version_info = get_version_info(version, schema_history_data)
        category = "Repeatable" if row["filename"][0] == "R" else "Versioned"
        if version_info:
            installed_on = str(version_info["installed_on"])
            state = "Success" if version_info["success"] else "Error"
            if (
                hashlib.sha256(
                    open(os.path.join("sql", row["filename"]), "rb").read()
                ).hexdigest()
                != version_info["checksum"]
            ):
                state = "Changed/Error"
        else:
            installed_on = ""
            state = "Pending"
        table_data.append(
            (
                category,
                version,
                description,
                "SQL",
                installed_on,
                state,
            )
        )
    table = Table(box=box.ASCII2)
    table.add_column("Category")
    table.add_column("Version")
    table.add_column("Description")
    table.add_column("Type")
    table.add_column("Installed on")
    table.add_column("State")
    for row in table_data:
        table.add_row(*row)

    console = Console()
    console.print(table)


@click.group()
@click.option(
    "--config-file",
    "-c",
    default="dbmt.yml",
    help="Config file for dbmt, default dbmt.yml",
)
def start(config_file):
    """db-migration-tool

    Small utilitiy for sql migration from a source repo"""
    load_config_file(config_file)


@start.command(help="Migrate database")
def migrate():
    migrate_database()


@start.command(help="Clean database")
def clean():
    clean_database()


@start.command(help="Status of database migration")
def info():
    database_info()
