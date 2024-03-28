<h1 align="center">
  <img alt="Globoplay" src="https://i.imgur.com/VSvQZMT.png" width="250px" />
</h1>


<p align="center">
  <a href="#page_with_curl-sobre">Sobre</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#sos-desafios">Desafios</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#hammer-tecnologias">Tecnologias</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#books-requisitos">Requisitos</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#rocket-iniciando">Iniciando</a>
</p>

<div align="center">
    <img alt="Splash" src="https://i.imgur.com/vfAOfsZ.png" width="220" />
    <img alt="Home" src="https://i.imgur.com/MJ3tm2X.png" width="220" />
    <img alt="Recommendations" src="https://i.imgur.com/ihNYO8C.png" width="220" />
</div>
<div align="center">
    <img alt="Starred" src="https://i.imgur.com/U2dQA2z.png" width="220" />
    <img alt="My list" src="https://i.imgur.com/e0V55N7.png" width="220" />
</div>

## :page_with_curl: Sobre

Este repositório é referente ao [**desafio mobile Globoplay**](https://github.com/globoi/globoplay-desafio-mobile?tab=readme-ov-file). Fiz o desafio para fins de estudo, afim de colocar em pratica alguns conhecimentos e também para me testar. No descritivo o desafio podia ser feito em até sete (7) dias. 

No meu caso, fiz em 4, dividindo da seguinte forma:
- **Dia 1**: Leitura do descritivo, planejamento dos endpoints da API do [**TMDB**](https://www.themoviedb.org/?language=pt-BR) e definição da arquitetura do projeto.
- **Dia 2 - 4**: Desenvolvimento do projeto em si, começando pela home, depois pagina de detalhes e posteriormente as features de navegação de telas, navegação entre abas e de salvar midias.

## :sos: Desafios

Um dos grandes desafios encontrados no desenvolvimento desse projeto foi a API do TMDB. Tentei pegar mídias disponíveis só no catálogo referente ao Globoplay, porém não obtive sucesso. Outra coisa também é que as midias não tem um certo padrão de estrutura(séries, filme, novela e etc), e é claro que, eu poderia contornar isso aplicando regras de negócio quando fosse consumir a API, mas creio que pelo tempo restritio não seria algo ideal a se fazer. Fora outros problemas pontuais que não consigo me recordar no momento, mas que busquei alternativa para solucioná-los.

Na parte de desennvolimento, um desafio interessante foi a feature de salvar as mídias. No caso, optei por usar o [**Shared preferences**](https://pub.dev/packages/shared_preferences) pela praticidade, mas creio que minha solução com ele poderia ser reaplicada em outros tipos de armazenamento sem nenhum problema. 

## :hammer: Tecnologias
Este projeto foi desenvolvodio em Flutter e é importante seu Flutter estar na mesma versão em que o projeto foi criado, pois caso contrário poderá haver conflitos. 

- Flutter 3.19.3 
- Dart 3.3.1 

## :books: Requisitos
- Ter [**Git**](https://git-scm.com/) para clonar o projeto.
- Ter [**Flutter**](https://docs.flutter.dev/get-started/install) configurado para executar o projeto.
- Um dispositivo ou emulador iOS ou Android.

## :rocket: Iniciando
``` bash
  # Clonar o projeto:
  $ https://github.com/davifariasp/globoplay-desafio.git

  # Entrar no diretório:
  $ cd globoplay-desafio
  
  # Instalar as dependências:
  $ flutter pub get
```
