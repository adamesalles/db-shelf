# SHELF DATABASE

Integrantes: Carol Erthal, Eduardo Adame e Tiago Barradas.

---

- Arquivo [wrapper.py](./wrapper.py) pega informações do tmdb e adiciona ao nosso database, levando em consideração os foreign keys e etc. 
- Arquivo [dbconnect.py](./dbconnect.py) apenas para testes.
- Arquivos `.sql` são auto descritivos. Os arquivos `estoque-data.sql` são os dumps que fiz direto do servidor do Linux. 

Basicamente só está faltando a tabela `shelf` e os outros tipos de work.

Os animes estão com id entre 275 e 371

Os criadores de anime estão com id entre 470 e 586

Os gêneros de anime estão com id entre 67 e 90


Links úteis: 


<https://www.mockaroo.com/schemas/341726> Esquema dos Likes das Reviews (0 a 3 são o tipo do like (0: dislike etc.), acabei mudando na tabela pra int.)

<https://www.mockaroo.com/schemas/341723> Esquema das Reviews (ver forma de colocar comentário. Aparentemente eu zoei ele ao fazer o de like.)

<https://dev.mysql.com/doc/mysql-tutorial-excerpt/5.7/en/example-auto-increment.html>

<https://www.mockaroo.com/> Gerador FAKE ótimo

<https://stackoverflow.com/questions/37616760/how-to-insert-timestamp-into-my-mysql-table>

<https://www.w3schools.com/sql/sql_default.asp>

<https://www.tvmaze.com/api> séries (REALMENTE MUITO BOM)

<https://www.igdb.com/api> jogos  (nem consegui usar, o <https://api.rawg.io/docs/> parece funcionar)

<https://imdb-api.com/api> filmes (não muito bom)

<https://jikan.moe/> animes/mangas 

<https://pynative.com/python-mysql-database-connection/>

<https://stackoverflow.com/questions/1809893/how-to-reset-the-primary-key-of-a-table>