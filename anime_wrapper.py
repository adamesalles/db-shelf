import requests
import mysql.connector
from mysql.connector import Error
from bs4 import BeautifulSoup

# SET PARA O TOP 100 ID
top_ids = set()

# SCRAPING DOS TOP 100 ID
for limit in (0, 50):
    html_text = requests.get(
        f'https://myanimelist.net/topanime.php?limit={limit}').text

    soup = BeautifulSoup(html_text, 'lxml')
    anime_elements = soup.find_all(
        'a', href=lambda x: x and x.startswith('https://myanimelist.net/anime/'), id=lambda x: x and x.startswith('#area'))
    for element in anime_elements:
        id = element['id'].strip('#area')
        top_ids.add(id)

# CONEXÃO COM O MYSQL
try:
    connection = mysql.connector.connect(host='192.168.1.103',
                                         database='estoque',
                                         user='root',
                                         port='6603',
                                         password='secreta')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor(buffered=True)
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

except Error as e:
    print("Error while connecting to MySQL", e)

# ACHA OU ADICIONA O ID DOS GÊNEROS E CRIADORES


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


# ADICIONA CADA ANIME
for id in top_ids:
    anime = requests.get(f'https://api.jikan.moe/v3/anime/{id}/').json()
    try:
        # ANIMES PODEM NÃO TER TÍTULO EM EN
        title = anime['title_english'] if anime['title_english'] else anime['title']
        title = title.replace("'", "''")  # ESCAPA OS '
        genres = anime['genres']
        producers = anime['producers']
        overview = anime['synopsis'].replace("'", "''")  # ESCAPA OS '
        if anime['studios'][0]['name']:  # ANIMES PODEM NÃO TER STUDIO
            publisher = anime['studios'][0]['name']
        else:
            publisher = ''
        released = anime['aired']['from'].strip(
            'T00:00:00+00:00')  # REMOVE O HORÁRIO
        cursor.execute(
            f"INSERT INTO works (name, type, publisher, synopsis, released) values ('{title}', 'Anime','{publisher}' , '{overview}', '{released}');")
        cursor.execute(f"SELECT id FROM works WHERE name = '{title}';")
        anime_id = cursor.fetchone()[0]
        for genre in genres:
            genre_id = find_id('genres', genre['name'])
            cursor.execute(
                f"INSERT INTO work_genres (works_id, genres_id) values ({anime_id}, {genre_id})")
        for producer in producers:
            producer_id = find_id('creators', producer['name'])
            cursor.execute(
                f"INSERT INTO work_creators (works_id, creators_id) values ({anime_id}, {producer_id})")
        print(title)
    except Exception as e:
        print(e)
        pass

if connection.is_connected():
    connection.commit()
    cursor.close()
    connection.close()
    print("MySQL connection is closed")
