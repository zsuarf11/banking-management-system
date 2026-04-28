import mysql.connector


def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="cuonggame12004",
        database="banking_management_system"
    )