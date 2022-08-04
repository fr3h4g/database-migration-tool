from typing import List, Dict, Any
import mysql.connector
from mysql.connector.cursor import MySQLCursor
from mysql.connector import MySQLConnection

from dbmt import database_plugin

from dbmt.config import CONFIG
from dbmt.dataclasses import MigrationData


class MySQLPlugin(database_plugin.Plugin):
    def __init__(self):
        self.__name__ = "mysql"
        self._check_config()
        # self._connect()
        # self._add_schema_history_table()

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

    def connect(self):
        print("connect")
        cnx = mysql.connector.connect(
            user=CONFIG["database"]["username"],
            password=CONFIG["database"]["password"],
            host=CONFIG["database"]["host"],
            database=CONFIG["database"]["database"],
        )
        self._cnx = cnx
        self._cursor = cnx.cursor()
        self._add_schema_history_table()

    def execute(self, sql):
        self._cursor.execute(sql)

    def commit(self):
        self._cnx.commit()

    def close(self):
        self._cnx.close()

    def _fetchone(self) -> Dict[Any, Any]:
        """Create dict from Mysql cursor response."""
        dict_data: Dict[Any, Any]
        desc = self._cursor.description
        column_names = [col[0] for col in desc]  # type: ignore
        db_data = self._cursor.fetchone()
        if db_data:
            dict_data = dict(zip(column_names, db_data))
            return dict_data
        else:
            dict_data = {}
            return dict_data

    def _fetchall(self) -> List[Dict[Any, Any]]:
        """Create dict from Mysql cursor response."""
        list_data: List[Dict[Any, Any]]
        desc = self._cursor.description
        column_names = [col[0] for col in desc]  # type: ignore
        db_data = self._cursor.fetchall()
        if db_data:
            list_data = [dict(zip(column_names, row)) for row in db_data]
            return list_data
        else:
            list_data = []
            return list_data

    def _add_schema_history_table(self):
        """runns before every script file"""

        sql = (
            "CREATE TABLE if not exists `dbmt_schema_history` ("
            "`id` INT NOT NULL AUTO_INCREMENT , "
            # "`version` VARCHAR(10) NOT NULL , "
            "`description` VARCHAR(255) NOT NULL , "
            "`script` VARCHAR(255) NOT NULL , "
            "`checksum` VARCHAR(64) NOT NULL , "
            "`installed_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , "
            "`total_queries` INT NOT NULL, "
            "`done_queries` INT NOT NULL, "
            "`success` INT NOT NULL, "
            "PRIMARY KEY (`id`) "
            ") ENGINE = InnoDB;"
        )
        self.execute(sql)
        self._cnx.commit()

    def get_schema_history_table_data(self):
        sql = "SELECT * FROM `dbmt_schema_history` ORDER BY id ASC;"
        self.execute(sql)
        data = []
        for row in self._fetchall():
            data.append(MigrationData(**row))
        return data

    def add_schema_history_table_entry(self):
        """runns on every script script file"""
        pass

    def update_schema_history_table_entry(self):
        """runns after every sql query in script file"""
        pass

    def add_database_lock(self):
        pass

    def remove_database_lock(self):
        pass

    def clean_all_tables(self):
        pass
