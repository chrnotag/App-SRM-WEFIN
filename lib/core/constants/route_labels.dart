import 'package:flutter_modular/flutter_modular.dart';

class AppRoutes {
  AppRoutes._();

  static final AppRoutes _instance = AppRoutes._();

  factory AppRoutes() {
    return _instance;
  }

  //Escopo AUT
  static get forgetPassAuthRoute => '/forgot_password';

  static get loginAuthRoute => Modular.initialRoute;

  //Escopo HOME
  static get homeRoute => '/home';

  static get listaSelecaoEmpresasHomeRoute => '/lista_empresas';

  static get secondScreenHomeRoute => '/second_screen';

  static get helpScreenHomeRoute => '/help_screen';

  static get monitorOperacoesHomeRoute => '/monitor_operacoes';

  static get assinaturaDigitalHomeRoute => '/assinatura';

  static get menuAppHomeRoute => '/menu_app';

  static get homeAppHomeRoute => '/home_app';

  static get importarCertificadoHomeRoute => '/importar_certificado';

  static get guiaImportarCertificadoHomeRoute => '/importar_dispositivo';

  static get leitorQrCodeHomeRoute => '/leitor-qr-code';

  //Escopo para troca de telas usando o Modular.to.navigate HOME
  static get listaSelecaoEmpresasRoute =>
      '$homeRoute$listaSelecaoEmpresasHomeRoute';

  static get secondScreenRoute => '$homeRoute$secondScreenHomeRoute';

  static get helpScreenRoute => '$homeRoute$helpScreenHomeRoute';

  static get monitorOperacoesRoute => '$homeRoute$monitorOperacoesHomeRoute';

  static get assinaturaDigitalRoute => '$homeRoute$assinaturaDigitalHomeRoute';

  static get menuAppRoute => '$homeRoute$menuAppHomeRoute';

  static get homeAppRoute => '$homeRoute$homeAppHomeRoute';

  static get importarCertificadoRoute =>
      '$homeRoute$importarCertificadoHomeRoute';

  static get guiaImportarCertificadoRoute =>
      '$homeRoute$guiaImportarCertificadoHomeRoute';

  // ESCOPO SEM CONEXÃO
  static get semConexaoMainRoute => '/sem-conexao';

  static get semConexaoRoute => '$semConexaoMainRoute/sem-conexao';

  //CONTA DIGITAL ROUTE
  static get ContaDigitalRoute => '/conta-digital';

  //ESCOPO CONTA DIGITAL ROUTE
  static get extratoScreenContaDigitalRoute => '/tela-extrato';

  static get selecionarDataScreenContaDigitalRoute => '/selecionar-data';

  static get visualizarPdfScreenContaDigitalRoute => '/visualizar-pdf';

  static get comprovanteTEDScreenContaDigitalRoute => '/comprovante-ted';

  //ESCOPO CONTA DIGITAL NAVIGATOR ROUTE
  static get extratoScreenRoute =>
      '$ContaDigitalRoute$extratoScreenContaDigitalRoute';

  static get selecionarDataScreenRoute =>
      '$ContaDigitalRoute$selecionarDataScreenContaDigitalRoute';

  static get visualizarPdfScreenRoute =>
      '$ContaDigitalRoute$visualizarPdfScreenContaDigitalRoute';

  static get visualizarComprovanteTEDScreenRoute =>
      '$ContaDigitalRoute$comprovanteTEDScreenContaDigitalRoute';
}
