# ExamApi / ExamApp

## Descrição

Gera números aleatórios para que o usuário reordene-os em ordem crescente.

* Versão Flutter SDK 3.24.3 (versionamento com [FVM](https://fvm.app/))
* Plataforma Android

### Componentes

1. **API**: Fornece métodos para gerar a quantidade de números solicitada e verificar se estão em ordem crescente.
2. **App**: Consome a API, permite que o usuário gere, reordene e verifique se os números estão em ordem crescente.

### Arquitetura

* Optei por Arquitetura Modular associada a Feature Driven Development, tratando cada funcionalidade (_feature_) como um módulo independente, que encapsula a lógica e a UI. Muito vantajoso para a escalabilidade, permitindo adicionar novas funcionalidades sem afetar as existentes.

* A API e o App estão em módulos completamente separados, simulando um cenário real em que o App consome APIs remotas.

* O módulo da API separa interface e implementação, expondo apenas o necessário para terceiros, e mantendo lógica segura e privada.

### Gerenciamento de Estado

* Como o App possui funcionalidades muito simples, optei pelo padrão _Provider + ChangeNotifier_ para criar uma espécie de ViewModel que separa a lógica de negócio da UI.

* Isso mantém a aplicação leve e fácil de ler, com menos dependências externas do que os outros padrões de gerenciamento de estado disponíveis.

### Interface

* Mantida simples e clean, seguindo o padrão do Material 3.

* Pensando na experiência de autoatendimento, priorizei instruções na tela para guiar o usuário pelo processo.

#### Reordenando os Números

* Optei pela funcionalidade de arrastar e soltar tiles, um processo intuitivo e conhecido por muitos usuários.

#### Validação de Resultado

* A validação ocorre automaticamente após cada movimentação, deixando o App fluido e eliminando a necessidade de tocar em um botão.

* Mesmo assim, adicionei um botão de "verificar", que dá mais segurança e sensação de controle ao usuário.

### Packages

Preferi usar poucos pacotes e evitar geradores de código para manter o projeto enxuto. As únicas bibliotecas importadas são:

* [provider](https://pub.dev/packages/provider) | gerenciamento de estado
* [mocktail](https://pub.dev/packages/mocktail) | criação de mocks em testes

## Stack Essencial para Desenvolvimento Flutter

Na entrevista fui perguntado sobre quais tecnologias e pacotes considero essenciais. Durante o desenvolvimento deste projeto, percebi que deixei de mencionar diversos pacotes que uso no dia a dia e sempre levo em consideração ao definir a arquitetura de um projeto. Alguns deles são:

* [FVM](https://fvm.app/) | gerenciamento de versões do Flutter SDK

* [Sentry](https://pub.dev/packages/sentry) / [Crashlytics](https://pub.dev/packages/firebase_crashlytics) | monitoramento de erros

* [BLoC](https://pub.dev/packages/flutter_bloc) | gerenciamento de estado mais usado em meus projetos

* [json_serializable](https://pub.dev/packages/json_serializable) | gerador de serialização

* [Equatable](https://pub.dev/packages/equatable) | operador de igualdade

* [freezed](https://pub.dev/packages/freezed) | gerador de código classes e unions

* [intl](https://pub.dev/packages/intl) | formatação e internacionalização

* [dart_either](https://pub.dev/packages/dart_either) | tratamento de erros e programação funcional
