# COMO ORGANIZAR AS CLASSES DENTRO DE CONSTANTS

* **Definição dos métodos de acesso:**

    1. **SEMPRE USAR PADRÃO SINGLETON**
       Para tal, utilize um construtor anonimo, defina uma variavel privada _instance para
       guardar a instancia atual e após a retorne no método factory.
       Basta seguir o modelo route_labels ja feito.
    2. **Utilize as váriaveis como Static get** para que o controle de acesso permita somente
       resgatar o valor
       da constante, e nunca altera-lo.