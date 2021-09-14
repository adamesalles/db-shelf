import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(host='192.168.1.103',
                                         database='estoque',
                                         user='root',
                                         port='6603',
                                         password='trolled')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)
        cursor.execute(
            "insert into user (username, name, email, password) values ('adame', 'Eduardo Adame', 'edu@adame.salles', 'senhamassa');")
        cursor.execute(f"SELECT id FROM user WHERE username = 'adame';")
        print(cursor.fetchone())

except Error as e:
    print("Error while connecting to MySQL", e)
finally:
    if connection.is_connected():
        connection.commit()
        cursor.close()
        connection.close()
        print("MySQL connection is closed")
