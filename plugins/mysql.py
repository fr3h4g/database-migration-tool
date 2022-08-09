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

    def add_schema_history_table(self):
        """runns before every script file"""

        sql = (
            "CREATE TABLE if not exists `dbmt_schema_history` ("
            "`id` INT NOT NULL , "
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
        self.add_schema_history_table()
        sql = "SELECT * FROM `dbmt_schema_history` ORDER BY id ASC;"
        self.execute(sql)
        data = []
        for row in self._fetchall():
            data.append(MigrationData(**row))
        return data

    def add_schema_history_table_entry(self, data: MigrationData):
        """runns on every script script file"""
        sql = f"SELECT id FROM `dbmt_schema_history` WHERE id='{data.id}' LIMIT 1"
        self.execute(sql)
        tmp = self._fetchone()
        if not tmp:
            sql = (
                "INSERT INTO `dbmt_schema_history` (id, script, total_queries, done_queries, "
                "description, checksum, success) "
                f"VALUES ('{data.id}','{data.script}','{data.total_queries}','{data.done_queries}',"
                f"'','{data.checksum}','0')"
            )
            self.execute(sql)

    def update_schema_history_table_entry(self, data: MigrationData, index_done: int):
        """runns after every sql query in script file"""
        success = "1" if index_done + 1 == data.total_queries else "0"
        sql = (
            f"UPDATE `dbmt_schema_history` SET done_queries='{index_done+1}', success='{success}' "
            f"WHERE id='{data.id}'"
        )
        self.execute(sql)

    def add_database_lock(self):
        pass

    def remove_database_lock(self):
        pass

    def clean_all_tables(self):
        sql = (
            "SELECT CONCAT('DROP TABLE IF EXISTS `', table_name, '`;') query "
            "FROM information_schema.tables "
            f"WHERE table_schema = '{CONFIG['database']['database']}';"
        )
        self.execute(sql)
        data = self._fetchall()
        for row in data:
            self.execute(row["query"])
        self.commit()
