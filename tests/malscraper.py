import requests
from bs4 import BeautifulSoup

top_ids = set()
for limit in (0, 50):
    html_text = requests.get(
        f'https://myanimelist.net/topanime.php?limit={limit}').text

    soup = BeautifulSoup(html_text, 'lxml')
    anime_elements = soup.find_all(
        'a', href=lambda x: x and x.startswith('https://myanimelist.net/anime/'), id=lambda x: x and x.startswith('#area'))
    for element in anime_elements:
        id = element['id'].strip('#area')
        top_ids.add(id)

for id in top_ids:
    print(requests.get(f'https://api.jikan.moe/v3/anime/{id}/').json())
