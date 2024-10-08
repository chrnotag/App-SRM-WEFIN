import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/login_implementation.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/models/auth_login_models/SRM/cedente_model.dart';
import 'package:Srm_Asset/models/auth_login_models/SRM/usuario_logado_model.dart';
import 'package:Srm_Asset/models/user_model.dart';
import '../../../constants/enuns/roles_acesso_enum.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._();

  static final _instance = AuthProvider._();

  factory AuthProvider() {
    return _instance;
  }

  Future<dynamic> login(UserModel userModel) async {
    credenciaisUsuario = userModel;
    return await LoginImpl(userModel: userModel).login();
  }

  late UserModel _credenciaisUsuario;

  UserModel get credenciaisUsuario => _credenciaisUsuario;

  set credenciaisUsuario(UserModel credenciais) =>
      _credenciaisUsuario = credenciais;

  String? _loginSalvo;
  String? get loginSalvo => _loginSalvo;
  set loginSalvo(String? login) => _loginSalvo = login;

  String? _tokenNotificacao;
  String? get tokenNotificacao => _tokenNotificacao;
  set tokenNotificacao(String? token) => _tokenNotificacao = token;

  LoginResponse? _dataUser;
  List<CedenteModel>? _listaCedente;
  CedenteModel? _empresaSelecionada;
  List<RolesAcessoEnum>? _rolesAcesso;

  LoginResponse? get dataUser => _dataUser;

  List<CedenteModel>? get listaCedente => _listaCedente;

  CedenteModel? get empresaSelecionada => _empresaSelecionada;

  List<RolesAcessoEnum>? get rolesAcesso => _rolesAcesso;

  set setDataUser(LoginResponse loginResponse) {
    _dataUser = loginResponse;
    _setListaCedente = loginResponse.listaCedente;
    empresaSelecionada = buscarEmpresa(loginResponse.identificadorCedente!);
  }

  set _setListaCedente(List<CedenteModel>? listaCedente) {
    _listaCedente = listaCedente!;
  }

  set empresaSelecionada(CedenteModel? cedente) {
    _empresaSelecionada = cedente;
    notifyListeners();
  }

  set rolesAcesso(List<RolesAcessoEnum>? roles) => _rolesAcesso = roles;

  CedenteModel buscarEmpresa(String identificadorCedente) {
    return dataUser!.listaCedente
        .firstWhere((cedente) => cedente.identificador == identificadorCedente);
  }

  Future<void> RelogarTrocarCedente(
      String identificadorCedente, BuildContext context) async {
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    if (empresaSelecionada!.identificador != identificadorCedente) {
      OverlayApp.iniciaOverlay(context);
      final credenciaisLogin = UserModel(
          usuario: credenciaisUsuario.usuario,
          senha: credenciaisUsuario.senha,
          tokenNotificacao: credenciaisUsuario.tokenNotificacao,
          idDevice: credenciaisUsuario.idDevice,
          identificadorCedente: identificadorCedente);

      final respostaLogin = await login(credenciaisLogin);
      if (respostaLogin != null && respostaLogin.error != null) {
        _erroTrocaCedente(respostaLogin);
      } else {
        final respostaAssinatura =
            await assinaturaProvider.carregarAssinaturas();
        if (respostaAssinatura.error != null) {
          _erroTrocaCedente(respostaAssinatura);
        } else {
          try {
            OverlayApp.terminaOverlay();
          } catch (_) {
          }
          final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
          await contaDigitalProvider.obterDadosContaDigital();
          await contaDigitalProvider.obterSaldoContaDigital();
        }
      }
    }
  }

  void _erroTrocaCedente(dynamic response) {
    OverlayApp.terminaOverlay();
    notifyListeners();
    Fluttertoast.showToast(
        msg: 'Erro ao acessar o cedente. Tente novamente mais tarde.');
  }

  void limparDadosUsuario() {
    _dataUser = null;
    _empresaSelecionada = null;
    _listaCedente = null;
    _credenciaisUsuario = UserModel(usuario: '', senha: '', tokenNotificacao: '',idDevice: '');
  }
}
