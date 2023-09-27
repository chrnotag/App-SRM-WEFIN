class AppRoutes {
  AppRoutes._();

  static final AppRoutes _instance = AppRoutes._();

  factory AppRoutes() {
    return _instance;
  }

  //Escopo AUT
  static get forgetPassAuthRoute => '/forgot_password';

  //Escopo HOME
  static get homeRoute => '/home';

  static get listaSelecaoEmpresasHomeRoute => '/lista_empresas';

  static get secondScreenHomeRoute => '/second_screen';

  static get helpScreenHomeRoute => '/help_screen';

  static get monitorOperacoesHomeRoute => '/monitor_operacoes';

  static get assinaturaDigitalHomeRoute => '/assinatura';

  static get menuAppHomeRoute => '/menu_app';

  //Escopo para troca de telas usando o Modular.to.navigate HOME
  static get listaSelecaoEmpresasRoute =>
      '$homeRoute$listaSelecaoEmpresasHomeRoute';

  static get secondScreenRoute => '$homeRoute$secondScreenHomeRoute';

  static get helpScreenRoute => '$homeRoute$helpScreenHomeRoute';

  static get monitorOperacoesRoute => '$homeRoute$monitorOperacoesHomeRoute';
  static get assinaturaDigitalRoute => '$homeRoute$assinaturaDigitalHomeRoute';

  static get menuAppRoute => '$homeRoute$menuAppHomeRoute';
}
