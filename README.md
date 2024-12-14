# App SRM/Trust

Este projeto Flutter utiliza flavors para gerenciar dois aplicativos diferentes ("SRM" e "Trust") dentro de um único código-fonte. Ambos compartilham grande parte da interface e funcionalidades, diferenciando-se apenas em alguns aspectos, como temas de cores e telas específicas.

-   **SRM**: Tema azul
-   ![image](https://github.com/user-attachments/assets/3b1cf261-adb2-4b19-99fe-fe0502aaeee2)

-   **Trust**: Tema verde
-   ![image](https://github.com/user-attachments/assets/ecbff6ea-748d-42fe-84f2-d384683cc2a5)

## Funcionalidades Compartilhadas

### Autenticação e Recuperação de Acesso

-   Login no sistema via API, integrado com **MongoDB**.

-   Recuperação de senha: Envio de e-mail com código de confirmação (recuperação realizada no site do **homebanking** das respectivas empresas para maior segurança).

### Gerenciamento de Cedentes

![image](https://github.com/user-attachments/assets/62d5276d-e5fa-4a6b-a9cd-42c0868650ad)

-   Possibilidade de **múltiplos cedentes** associados a uma conta.

-   Alternância de cedentes em tempo real, sem necessidade de logout.

### Homebanking

![image](https://github.com/user-attachments/assets/73978e5c-a63e-4c60-a166-ed394e2c7549)

-   Consulta de **saldo** e **extrato** da conta corrente.

-   Pesquisa de extratos por data específica ou intervalo (limite de 3 meses entre datas).

-   Transferências **TED** (exclusivo Trust).

### Monitor de Operações

![image](https://github.com/user-attachments/assets/c5c83e36-ca1e-41b2-ad5b-14042088da5b)

-   Monitoramento de status da **assinatura de documentos de crédito**.

    -   Assinaturas podem ser realizadas individualmente ou em grupo.

    -   Suporte a **certificados digitais A1** (importados do dispositivo) e **assinaturas eletrônicas**.

### Certificados Digitais

-   Importação de certificados digitais.
    -   ![image](https://github.com/user-attachments/assets/d8946581-77d0-42fc-970d-598ff1d49c02)
-   Notificação de vencimento próximo de certificados.

-   Exclusão de certificados vencidos.

### Notificações

-   **Push notifications** em tempo real sobre novas operações e status de assinatura.

### Emissão de Extratos
![image](https://github.com/user-attachments/assets/cb84f9bd-0658-4aaa-ad45-98460ad092bb)

-   Geração de extratos em formato **PDF**, com opção de salvar ou compartilhar (via **shared_plus**).

### Responsividade

-   Layout responsivo utilizando a biblioteca **screen_utils**.

### Outros Recursos

-   Tratamento de erros e sucessos com **generics** do Dart.

-   Monitoramento em tempo real da conexão com a internet (**Observer pattern**).

-   Limitação de tempo de sessão (logout após 120 segundos de inatividade).

-   Armazenamento seguro de credenciais no dispositivo.

## Arquitetura e Tecnologias

### Estrutura do App

-   Arquitetura **MVVM**.

-   Gerenciamento de estados com **Provider**.

-   Navegação e injeção de dependências utilizando **Modular**.

-   **Micro-front-end** para facilitar a construção de telas e reaproveitamento de widgets.

### Gerenciamento de Builds

-   Configuração de perfis de build com **Flutter Flavors** e **Flavorizr**.

-   Scripts automatizados para builds em **Windows** e **Mac** (*.cmd* e *.zshc*).

### Integrações e Conexões

-   Gerenciamento de conexões com APIs utilizando **http**.

-   Notificações push e monitoramento de sessão com **streams**.

## Limitação de Acesso

-   Gerenciamento de **roles de acesso** para controle de recursos e funcionalidades dentro do app.
