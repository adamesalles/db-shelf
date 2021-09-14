# AINDA EM CONSTRUÇÃO
import random
import requests
import mysql.connector
from mysql.connector import Error

# requests.get('https://api.tvmaze.com/shows/1') mudar último número.
# requests.get('https://api.tvmaze.com/shows/1') mudar último número.

try:
    connection = mysql.connector.connect(host='192.168.1.103',
                                         database='estoque',
                                         user='root',
                                         port='6603',
                                         password='secreta')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

except Error as e:
    print("Error while connecting to MySQL", e)


def find_id(table, name):
    cursor.execute(f"SELECT id FROM {table} WHERE {table[:-1]} = '{name}';")
    record = cursor.fetchone()
    if not record:
        cursor.execute(
            f"INSERT INTO {table} ({table[:-1]}) values ('{name}');")
        cursor.execute(
            f"SELECT id FROM {table} WHERE {table[:-1]} = '{name}';")
        record = cursor.fetchone()
    return record[0]


for index in range(62, 250):
    movie = tmdb.Movies(index)
    try:
        # response = movie.info()
        title = movie.info()['title']
        genres = movie.info()['genres']
        producers = movie.info()['production_companies']
        overview = movie.info()['overview'].replace("'", "''")
        release_date = movie.info()['release_date']
        # movie.info()['production_companies'][j]['name'])
        # movie.info()['genres'][j]['name']
        cursor.execute(
            f"INSERT INTO works (name, type, synopsis, released) values ('{title}', 'Movie', '{overview}', '{release_date}');")
        cursor.execute(f"SELECT id FROM works WHERE name = '{title}';")
        movie_id = cursor.fetchone()[0]
        for genre in genres:
            genre_id = find_id('genres', genre['name'])
            cursor.execute(
                f"INSERT INTO work_genres (works_id, genres_id) values ({movie_id}, {genre_id})")
        for producer in producers:
            producer_id = find_id('creators', producer['name'])
            cursor.execute(
                f"INSERT INTO work_creators (works_id, creators_id) values ({movie_id}, {producer_id})")
        print(title)
    except Exception as e:
        print(e)
        pass

if connection.is_connected():
    connection.commit()
    cursor.close()
    connection.close()
    print("MySQL connection is closed")
