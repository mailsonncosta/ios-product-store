# ios-product-store

## Arquitetura

A arquitetura usada é o MVVM, pois possibilita a modularidade e facilita no momento de realizar os testes, além de reduzir a quantidade de código necessário para conectar o modelo com a view.

## Bibliotecas

A única biblioteca adicionada foi a do swiftlint, pois faciliata observar os problemas de lint  durante o processo de build. Ela foi adicionada via cocoapods e é executada ao gerar a build utilizando um script.

## Decisões

#### - O aplicativo pode rodar nos modos rertrato e paisagem. A tela de detalhes do dispositivo muda a disposição dos elementos dependendo do tamanho da tela.

#### - O core data foi adicionado ao projeto, ele está sendo utlizado para testes de CRUD, apesar de o aplicativo não estar usando os dados salvos para preencher as views.

#### - Por problemas com o atributo layer.shadow nas views, eu acabei criando uma extensão para adicionar as sombras programaticamente

#### - Como não tenho o iOS 12.0 disponível no meu Xcode, coloquei a versão mínima como 12.1

#### - Foram adicionados o ícone para o aplicativo e também uma imagem na tela de Splash

## Como exercutar o projeto

Para executar o projeto, basta fazer o clone a abrir o projeto via o arquivo de extensão **.workspace**. 


