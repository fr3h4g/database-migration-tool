import os
import re
import yaml
import rich
from dbmt.error import print_error


VERBOSE = False
CHECK_VARIABLES = False
CONFIG = {}
DRY_RUN = False
DIR = "./sql"


def replace_with_os_env(row: str, error_place="config file"):
    error = False
    if row.lstrip() and row.lstrip()[0] != "#":
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

    return CONFIG
