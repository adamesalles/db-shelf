# SHELF DATABASE

Integrantes: Ana Carol Erthal, Eduardo Adame e Tiago Barradas.

---
Versão mais recente [aqui](./dumps/estoque-16-09-21.sql).
O trabalho consiste em um banco de dados de um site estante, no estilo do [TV Time](https://www.tvtime.com/), mas reunindo diversos tipos de entretenimento: filmes, animes, jogos e livros. Além de organização própria, o site provê relações entre usuários através de follows, reviews e etc..

Nossos dados foram gerados, quando falsos, a partir do site [Mockaroo](https://www.mockaroo.com/). Para descrever as obras, utilizamos de APIs e informações melhor descritas a seguir:


## Relações user-user

### users
Reúne informações básicas do usuário e de sua conta

### user_followers
Tabela que descreve as relações de follow entre usuários usuários, sendo *source* o usuário que seguiu e *target_id* o usuário que foi seguido. Armazena o momento em que a relação foi estabelecida.

## Relações work-work

### works
Dados de cada obra, sendo *type* o definido entre Movie, Anime, Game e Book. 

Há, na parte de população dessa categoria, dois formatos de inserção de dados. Essa diferença se dá à diferença de experiência de programação entre os membros do grupo. Desenvolvemos tudo de forma síncrona, mas preferimos dar espaço para cada um crescer programaticamente, sem necessidade de se refrear ou ficar em segundo plano.

 Os filmes e animes e suas informações foram obtidos a partir de APIs, sendo o de filmes a partir de [filmes](https://www.themoviedb.org/?language=pt-BR) e o de [animes](https://myanimelist.net/):

- Arquivo [wrapper.py](./movie_wrapper.py) pega informações do tmdb e adiciona ao nosso database, levando em consideração os foreign keys e etc.
- Arquivo [wrapper.py](./anime_wrapper.py) pega informações do myanimelist e adiciona ao nosso database, levando em consideração os foreign keys e etc. 

As informações de livros foram obtidas a partir [desse database](https://gist.github.com/jaidevd/23aef12e9bf56c618c41) e as de jogos a partir da base de dados [vgsales](https://www.kaggle.com/kedokedokedo/vgsales), ambas manipuladas através do Python e Pandas e, também, do Mockaroo.

### genres

Reúne todos os gêneros possíveis para as obras de todos os tipos, associando-os a um id. Obtidos a partir dos mesmos métodos que _works_.

### creators
Reúne todos os criadores possíveis para as obras de todos os tipos(desenvolvedoras, autores,etc), associando-os a um id. Obtidos a partir dos mesmos métodos que _works_.

### work_genres
Relaciona works a gêneros. Cada work pode ter mais de um gênero.

### work_creators
Relaciona works a criadores. Cada work pode ter mais de um criador.

## Relações user-work

### statuses
Armazena as possibilidades de status, que serão utilizadas como FKs em _shelf_. São eles: On Progress, Finished, On Wishlist, Dropped.

### shelf
Dados da estante em si. Tem FKs do id primário de *user*, de *statuses* e *works*, então contém tudo que é necessário para organizar a estante de cada usuário.

### reviews
Dados de cade review feita pelos usuários, contando com *score*. Se relaciona consigo mesma, pois é possível fazer uma review sobre outra review (que, na prática, configura um sistema de comentários). Quando uma review é como um comentário de outra, o score tem valor de atribuição à review original.

### review_likes
Dados dos likes. Recebe PK do usuário que interagiu com a review, e da própria review. Além disso, conta com *type*, um interger para caracterizar os diferentes tipos de interação (like, deslike, haha, triste). 


## Observações
- Pasta [tests](./tests/) apenas para testes.
- Arquivos `.sql` são auto descritivos. Os arquivos `estoque-data.sql` (na pasta [dumps](./dumps/)) são dumps. 
