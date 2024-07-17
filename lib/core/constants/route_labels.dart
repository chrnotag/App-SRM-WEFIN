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
  static get homeModuleRoute => '/home';

  static get listaSelecaoEmpresasModuleRoute => '/lista_empresas';

  static get secondScreenModuleRoute => '/second_screen';

  static get helpScreenModuleRoute => '/help_screen';

  static get monitorOperacoesModuleRoute => '/monitor_operacoes';

  static get assinaturaDigitalModuleRoute => '/assinatura';

  static get menuAppModuleRoute => '/menu_app';

  static get homeAppModuleRoute => '/home_app';

  static get importarCertificadoModuleRoute => '/importar_certificado';

  static get guiaImportarCertificadoModuleRoute => '/importar_dispositivo';

  static get leitorQrCodeModuleRoute => '/leitor-qr-code';

  //ESCOPO HOME NAVIGATOR
  static get listaSelecaoEmpresasNavigatorRoute =>
      '$homeModuleRoute$listaSelecaoEmpresasModuleRoute';

  static get secondScreenNavigatorRoute => '$homeModuleRoute$secondScreenModuleRoute';

  static get helpScreenNavigatorRoute => '$homeModuleRoute$helpScreenModuleRoute';

  static get monitorOperacoesNavigatorRoute => '$homeModuleRoute$monitorOperacoesModuleRoute';

  static get assinaturaDigitalNavigatorRoute => '$homeModuleRoute$assinaturaDigitalModuleRoute';

  static get menuAppNavigatorRoute => '$homeModuleRoute$menuAppModuleRoute';

  static get homeAppNavigatorRoute => '$homeModuleRoute$homeAppModuleRoute';

  static get importarCertificadoNavigatorRoute =>
      '$homeModuleRoute$importarCertificadoModuleRoute';

  static get guiaImportarCertificadoNavigatorRoute =>
      '$homeModuleRoute$guiaImportarCertificadoModuleRoute';

  // ESCOPO SEM CONEXÃO
  static get semConexaoMainRoute => '/sem-conexao';

  static get semConexaoRoute => '$semConexaoMainRoute/sem-conexao';

  //CONTA DIGITAL ROUTE
  static get ContaDigitalModuleRoute => '/conta-digital';

  //ESCOPO CONTA DIGITAL ROUTE
  static get extratoContaDigitalScreenRoute => '/tela-extrato';

  static get selecionarDataContaDigitalScreenRoute => '/selecionar-data';

  static get visualizarPdfContaDigitalScreenRoute => '/visualizar-pdf';

  static get comprovanteTEDContaDigitalScreenRoute => '/comprovante-ted';

  static get extratoDataSelecionadaScreenRoute => '/extrato-data-selecionada';

  //ESCOPO CONTA DIGITAL NAVIGATOR ROUTE
  static get extratoNavigatorRoute =>
      '$ContaDigitalModuleRoute$extratoContaDigitalScreenRoute';

  static get selecionarDataNavigatorRoute =>
      '$ContaDigitalModuleRoute$selecionarDataContaDigitalScreenRoute';

  static get visualizarPdfNavigatorRoute =>
      '$ContaDigitalModuleRoute$visualizarPdfContaDigitalScreenRoute';

  static get visualizarComprovanteTEDNavigatorRoute =>
      '$ContaDigitalModuleRoute$comprovanteTEDContaDigitalScreenRoute';

  static get extratoDataSelecionadaNavigatorRoute => '$ContaDigitalModuleRoute$extratoDataSelecionadaScreenRoute';

  //CARTEIRA CONSOLIDADA ROUTE
static get carteiraConsolidadaModuleRoute => '/carteira-consolidada';

 //ESCOPO CARTEIRA CONSOLIDADA
static get carteiraConsolidadaScreenRoute => '/screen';

  //ESCOPO CARTEIRA CONSOLIDADA NAVIGATOR ROUTE
static get carteiraConsolidadaNavigatorRoute => '$carteiraConsolidadaModuleRoute$carteiraConsolidadaScreenRoute';



  //TED PARA TERCEIROS ROUTE
static get tedTerceirosModuleRoute => '/ted-terceiros';

  //ESCOPO TED PARA TERCEIROS
static get tedTerceirosScreenRoute => '/ted-screen';

 //ESCOPO TED PARA TERCEIROS  NAVIGATOR ROUTE
static get tedTerceirosNavigatorRoute => '$tedTerceirosModuleRoute$tedTerceirosScreenRoute';



  //TRASNFERENCIAS ROUTE
static get transferenciasModuleRoute => '/transferencias';

  //ESCOPO TED PARA TERCEIROS
static get transferenciasScreenRoute => '/transferencias-screen';

  //ESCOPO TRANSFERENCIAS NAVIGATOR ROUTE
static get transferenciasNavigatorRoute => '$transferenciasModuleRoute$transferenciasScreenRoute';
}
