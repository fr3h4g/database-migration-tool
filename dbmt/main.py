from datetime import datetime
import os
from dataclasses import dataclass
from pydoc import describe
from unicodedata import category
import hashlib

import click
import rich
from rich.console import Console
from rich.table import Table, box
from rich import print as rprint
from rich.progress import track, Progress, BarColumn, TextColumn
import sqlparse

from dbmt.config import load_config_file
from dbmt.dataclasses import MigrationData
from dbmt.mysql import (
    connect_to_mysql,
    mysql_execute,
    mysql_cursor_fetchone,
    mysql_cursor_fetchall,
)
from dbmt.database_plugin import DatabasePlugin
from dbmt.error import print_error
from dbmt.config import VERBOSE, CHECK_VARIABLES, CONFIG, DRY_RUN, DIR


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
    cnx.commit()


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


def generate_line(len: int, chr: str = "-") -> str:
    string = ""
    for _ in range(len):
        string += chr
    return string


def clean_database():
    database = DatabasePlugin(CONFIG["database"]["database_plugin"])
    database.connect()
    database.clean_all_tables()
    database.commit()
    database.close()


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
    database = DatabasePlugin(CONFIG["database"]["database_plugin"])
    database.connect()
    migration_info_data = get_migration_info_data(database)
    table_data = []
    for index in migration_info_data:
        row = migration_info_data[index]
        id = str(row.id)
        description = str(row.description)
        script = str(row.script)
        total = str(row.total_queries)
        done = str(row.done_queries)
        installed_on = str(row.installed_on)
        state = str(row.success)
        table_data.append(
            (
                id,
                description,
                "SQL",
                script,
                total,
                done,
                installed_on,
                state,
            )
        )
    table = Table(box=box.ASCII2)
    table.add_column("Id")
    table.add_column("Description")
    table.add_column("Type")
    table.add_column("Script")
    table.add_column("Total queries")
    table.add_column("Done queries")
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
    default="dbchangelog.yaml",
    help="Config file for dbmt, default=dbmt.yml",
)
@click.option(
    "--dry-run/--no-dry-run",
    default=False,
    help="Dry run on prints sql queries, wont execute any, default --no-dry-run",
)
@click.option(
    "-d",
    "--directory",
    default="sql",
    help="Directory with sql scripts, defalult=./sql",
)
def start(config_file, dry_run, directory):
    """db-migration-tool

    Small utilitiy for sql migration from a source repo"""

    global DRY_RUN
    global DIR
    global CONFIG

    DIR = directory
    DRY_RUN = dry_run

    CONFIG = load_config_file(os.path.join(DIR, config_file))


@start.command(help="Migrate database")
def migrate():
    migrate_database()


@start.command(help="Clean database")
def clean():
    clean_database()


@start.command(help="Status of database migration")
def info():
    database_info()


def load_sql_queries(filename):
    sql_queries = None
    with open(os.path.join("sql", filename), "r") as stream:
        sql = stream.read()
        sql_queries = sqlparse.split(sql)
    return sql_queries


def get_scripts_data():
    script_data = []
    for change_set in CONFIG["databaseMigrations"]:
        filename = change_set["sqlFile"]
        with open(os.path.join(DIR, filename), "r") as stream:
            sql_text = stream.read()
            sql_queries = sqlparse.split(sql_text)
            checksum = hashlib.sha256(sql_text.encode()).hexdigest()
            script_data.append(
                MigrationData(
                    **{
                        "id": change_set["changeSet"],
                        "description": "",
                        "script": filename,
                        "checksum": checksum,
                        "sql_queries": sql_queries,
                        "total_queries": len(sql_queries),
                    }
                )
            )
    return script_data


def merge_migration_data(schema_history_table_data, scripts_data):
    merge_data = {}
    for row in scripts_data:
        if row.id not in merge_data:
            merge_data[row.id] = row
    for row in schema_history_table_data:
        if row.id not in merge_data:
            merge_data[row.id] = row
        else:
            if row.checksum != merge_data[row.id].checksum:
                print("error")
            merge_data[row.id].done_queries = row.done_queries
            merge_data[row.id].success = row.success
            merge_data[row.id].installed_on = row.installed_on

    return merge_data


def migrate_database():
    database = DatabasePlugin(CONFIG["database"]["database_plugin"])
    database.connect()

    database.add_schema_history_table()

    migration_info_data = get_migration_info_data(database)

    for key in migration_info_data:
        data = migration_info_data[key]

        database.add_schema_history_table_entry(data)

        if data.done_queries < data.total_queries:
            for index in range(data.done_queries, data.total_queries):
                sql = data.sql_queries[index]
                database.execute(sql)
                database.update_schema_history_table_entry(data, index)

    database.commit()
    database.close()


def get_migration_info_data(database):
    schema_history_table_data = database.get_schema_history_table_data()
    scripts_data = get_scripts_data()
    migration_info_data = merge_migration_data(schema_history_table_data, scripts_data)
    return migration_info_data
