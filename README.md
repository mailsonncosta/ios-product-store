# ios-product-store

## Arquitetura

A arquitetura usada é o MVVM, pois possibilita a modularidade e facilita no momento de realizar os testes, além de reduzir a quantidade de código necessário para conectar o modelo com a view.

O projeto está dividido em pastas:
    - Controllers
    - SupportFiles
    - Helpers
    - Models
    
Existem alguns testes de unidade relacionado a CRUD

## Bibliotecas

A única biblioteca adicionada foi a do swiftlint, pois faciliata observar os problemas de lint  durante o processo de build. Ela foi adicionada via cocoapods e é executada ao gerar a build utilizando um script.

## Decisões

#### - O aplicativo pode rodar nos modos retrato e paisagem. A tela de detalhes do dispositivo muda a disposição dos elementos dependendo do tamanho da tela.

#### - O core data foi adicionado ao projeto, ele está sendo utilizado para testes de CRUD, apesar de o aplicativo não estar usando os dados salvos para preencher as views.

#### - Como não tenho o iOS 12.0 disponível no meu Xcode, coloquei a versão mínima como 12.1, também não testei em dispositivos físicos

#### - Foram adicionados o ícone para o aplicativo e também uma imagem na tela de Splash

#### - Tentei adicionar algumas coisas relacionado a verificação de internet, mas infelizmente, não ficou muito bom e eu excluí.

## Como exercutar o projeto

   Para executar o projeto, basta fazer o clone e rodar na pasta que contem o arquivo de extensão **.workspace** o comando abaixo:
   
       pod install

   Caso você não tenha o cocoapods instalado na sua máquina, por favor seguir os passos abaixo:
   
    1) Digite no terminal:
        sudo gem install cocoapods
        - O Gem será instalado no Ruby dentro da biblioteca do sistema.
        
    2) Ou você pode usar:
        sudo gem install -n /usr/local/bin cocoapods
        
    3) Se houver um erro "o activesupport requer a versão Ruby> = 2.xx", instale o último suporte ativo:
        sudo gem install activesupport
        
    4) Em seguida, você precisa configurar o repositório principal dos cocoapods. Digite no terminal:
        pod setup
        - Aguarde o download.
        
    5) Em seguida, no terminal cd,vá no diretório onde você clonou o projeto (Onde contém o arquivo de extensão **.workspace**), e digite:
        pod install


