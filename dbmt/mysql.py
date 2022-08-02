from typing import List, Dict, Any
import mysql.connector
from mysql.connector.cursor import MySQLCursor
from mysql.connector import MySQLConnection


def connect_to_mysql(
    user="", password="", host="", database=""
) -> MySQLConnection:  # pragma: no cover
    """Connect to the MySQL server."""
    cnx = mysql.connector.connect(
        user=user,
        password=password,
        host=host,
        database=database,
    )
    return cnx  # type: ignore


def mysql_execute(cnx: MySQLConnection, sql: str) -> MySQLCursor:
    cursor = cnx.cursor()
    try:
        cursor.execute(sql)
    except Exception as ex:
        cnx.close()
        raise ex
    return cursor


def mysql_cursor_fetchone(cursor: MySQLCursor) -> Dict[Any, Any]:
    """Create dict from Mysql cursor response."""
    dict_data: Dict[Any, Any]
    desc = cursor.description
    column_names = [col[0] for col in desc]  # type: ignore
    db_data = cursor.fetchone()
    if db_data:
        dict_data = dict(zip(column_names, db_data))
        return dict_data
    else:
        dict_data = {}
        return dict_data


def mysql_cursor_fetchall(cursor: MySQLCursor) -> List[Dict[Any, Any]]:
    """Create dict from Mysql cursor response."""
    list_data: List[Dict[Any, Any]]
    desc = cursor.description
    column_names = [col[0] for col in desc]  # type: ignore
    db_data = cursor.fetchall()
    if db_data:
        list_data = [dict(zip(column_names, row)) for row in db_data]
        return list_data
    else:
        list_data = []
        return list_data
