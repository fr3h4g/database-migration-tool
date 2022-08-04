from typing import List, Dict, Any
import mysql.connector
from mysql.connector.cursor import MySQLCursor
from mysql.connector import MySQLConnection

from dbmt import plugin_collection

from dbmt.config import CONFIG


class MySQLPlugin(plugin_collection.Plugin):
    def __init__(self):
        self.__name__ = "mysql"
        self._check_config()
        self._connect()
        self._add_schema_history_table()

    def _check_config(self):
        if not CONFIG["database"]:
            raise ValueError("database is missing in config.")
        if not CONFIG["database"]["host"]:
            raise ValueError("database.host is missing in config.")
        if not CONFIG["database"]["username"]:
            raise ValueError("database.username is missing in config.")
        if not CONFIG["database"]["password"]:
            raise ValueError("database.password is missing in config.")
        if not CONFIG["database"]["database"]:
            raise ValueError("database.database is missing in config.")

    def _connect(self):
        print("connect")
        cnx = mysql.connector.connect(
            user=CONFIG["database"]["username"],
            password=CONFIG["database"]["password"],
            host=CONFIG["database"]["host"],
            database=CONFIG["database"]["database"],
        )
        self._cnx = cnx
        self._cursor = cnx.cursor()

    def execute(self, sql):
        self._cursor.execute(sql)

    def commit(self):
        self._cnx.commit()

    def close(self):
        self._cnx.close()

    def _add_schema_history_table(self):
        """runns before every script file"""

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
        self.execute(sql)
        self._cnx.commit()

    def update_schema_history_table(self):
        """runns after every sql query in script file"""
        pass

    def add_database_lock(self):
        pass

    def remove_database_lock(self):
        pass

    def clean_all_tables(self):
        pass
