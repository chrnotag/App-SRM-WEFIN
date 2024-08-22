import 'dart:typed_data';

import 'package:Srm_Asset/core/constants/enuns/tipo_conta_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/string_extensions.dart';
import 'package:Srm_Asset/core/providers/conta_digital/solicitar_ted/solicitar_ted_impl.dart';
import 'package:Srm_Asset/core/utils/toast_erro_util.dart';
import 'package:Srm_Asset/models/beneficiarios_recentes/beneficiarios_recentes_model.dart';
import 'package:Srm_Asset/models/conta_digital/solicitar_ted/resposta_token/resposta_token_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../../models/conta_digital/bancos/bancos_model.dart';
import '../../../../models/conta_digital/finalidades_ted/finalidades_ted_model.dart';
import '../../../../models/conta_digital/solicitar_ted/parametro/solicitar_ted_parametro_model.dart';
import '../../../../models/conta_digital/solicitar_ted/resposta/solicitar_ted_resposta.dart';
import '../../../implementations_config/api_response.dart';
import 'bancos_impl.dart';
import 'finalidades_ted_impl.dart';

class SolicitarTedProvider extends ChangeNotifier {
  Future<ApiResponse<dynamic>> solicitarTed(SolicitarTedParametroModel parametro) async {
    final response = await SolicitarTedRespostaImpl.solicitarTed(parametro);
    notifyListeners();
    if (response.error == null) {
      solicitarTedResposta = response.data;
    } else {
      showToast('Erro ao solicitar Ted', response);
    }
    return response;
  }

  Future<ApiResponse<dynamic>>? _futureSolicitarTed;

  Future<ApiResponse<dynamic>>? get futureSolicitarTed => _futureSolicitarTed;

  set futureSolicitarTed(Future<ApiResponse<dynamic>>? future) =>
      _futureSolicitarTed = future;

  Future<void> carregarBancos(String? codigoBanco) async {
    final response = await BancosModelImpl.carregarBancos(codigoBanco);
    if (response.error == null) {
      listaBancos = response.data..sort((a, b) => int.parse(a.codigo).compareTo(int.parse(b.codigo)));
      notifyListeners();
    } else {
      showToast('Erro ao carregar lista de bancos', response);
    }
  }

  Future<ApiResponse<dynamic>>? _futureListaBancos;

  Future<ApiResponse<dynamic>>? get futureListaBancos => _futureListaBancos;

  set futureListaBancos(Future<ApiResponse<dynamic>>? future) =>
      _futureListaBancos = future;

  Future<void> carregarFinalidadesTed() async {
    final response = await FinalidadesTedModelImpl.pegarFinalidades();
    if (response.error == null) {
      listaFinalidades = response.data;
      notifyListeners();
    } else {
      showToast('Erro ao carregar lista de finalidades', response);
    }
  }

  Future<ApiResponse<dynamic>>? _futureFinalidades;

  Future<ApiResponse<dynamic>>? get futureFinalidades => _futureFinalidades;

  set futureFinalidades(Future<ApiResponse<dynamic>>? future) =>
      _futureFinalidades = future;

  Future<void> carregarDados() async {
    await Future.wait([
      carregarBancos(null),
      carregarFinalidadesTed(),
    ]);
  }

  Future<void>? _futureDados;

  Future<void>? get futureDados => _futureDados;

  set futureDados(Future<void>? future) {
    _futureDados = future;
    notifyListeners();
  }

  RespostaTokenModel? _respostaToken;
  RespostaTokenModel? get respostaToken => _respostaToken;
  set respostaToken(RespostaTokenModel? resposta) => _respostaToken = resposta;

  Future<bool> enviarToken() async {
    final response = await SolicitarTedRespostaImpl.enviarToken();
    if (response.error == null) {
      respostaToken = response.data;
      return true;
    } else {
      return false;
    }
  }

  List<BancosModel> _listaBancos = [];

  List<BancosModel> get listaBancos => _listaBancos;

  set listaBancos(List<BancosModel> bancos) {
    _listaBancos = bancos;
    notifyListeners();
  }

  BancosModel? _bancoSelecionado;

  BancosModel? get bancoSelecionado => _bancoSelecionado;

  set bancoSelecionado(BancosModel? banco) {
    _bancoSelecionado = banco;
    notifyListeners();
  }

  List<FinalidadesTedModel>? _listaFinalidades;

  List<FinalidadesTedModel>? get listaFinalidades => _listaFinalidades;

  set listaFinalidades(List<FinalidadesTedModel>? finalidades) {
    _listaFinalidades = finalidades;
    notifyListeners();
  }

  SolicitarTedResposta? _solicitarTed;

  SolicitarTedResposta? get solicitarTedResposta => _solicitarTed;

  set solicitarTedResposta(SolicitarTedResposta? resposta) {
    _solicitarTed = resposta;
    notifyListeners();
  }

  String? _tipoConta;

  String? get tipoConta => _tipoConta;

  set tipoConta(String? listaItens) => _tipoConta = listaItens;

  List<String> get listaTiposConta =>
      ['Conta Corrente', 'Conta pagamento', 'Conta Deposito'];

  String _tipoContaSelecionada = 'Conta Corrente';

  String get tipoContaSelecionada => _tipoContaSelecionada;

  set tipoContaSelecionada(String item) => _tipoContaSelecionada = item;

  String _codigo = '';

  String get codigoToken => _codigo;

  void atualizarCodigo(String value, int index) {
    if (index < _codigo.length) {
      _codigo =
          _codigo.substring(0, index) + value + _codigo.substring(index + 1);
    } else {
      _codigo += value;
    }
    notifyListeners();
  }

  void deletarCodigo(int index) {
    if (_codigo.isNotEmpty && index < _codigo.length) {
      _codigo = _codigo.substring(0, index) + _codigo.substring(index + 1);
    }
    notifyListeners();
  }

  String? _agencia;

  String? get agencia => _agencia;

  set agencia(String? value) {
    _agencia = value;
    notifyListeners();
  }

  String? _conta;

  String? get conta => _conta;

  set conta(String? value) {
    _conta = value;
    notifyListeners();
  }

  double? _valor;

  double? get valor => _valor;

  set valor(double? value) {
    _valor = value;
    notifyListeners();
  }

  String? _nome;

  String? get nome => _nome;

  set nome(String? value) {
    _nome = value;
    notifyListeners();
  }

  String? _idBeneficiario;

  String? get idBeneficiario => _idBeneficiario;

  set idBeneficiario(String? value) {
    _idBeneficiario = value;
    notifyListeners();
  }

  final TextEditingController controllerAgencia = TextEditingController();
  final TextEditingController controllerConta = TextEditingController();
  final TextEditingController controllerValor = TextEditingController();
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerIdBeneficiario = TextEditingController();
  final TextEditingController controllerBancoSelecionado = TextEditingController();

  void autoPreencherFavorito(BeneficiariosRecentesModel beneficiario){
    controllerAgencia.text = beneficiario.agencia;

    tipoConta = beneficiario.tipoConta;

    controllerIdBeneficiario.text = beneficiario
        .identificadorBeneficiario.formatarDocumento();

    controllerConta.text = beneficiario.numeroConta;

    controllerNome.text= beneficiario
        .nomeBeneficiario;

    bancoSelecionado =
        listaBancos.firstWhere(
              (element) => beneficiario
              .codigoBanco ==
              element.codigo,
        );
    controllerBancoSelecionado.text =  '${bancoSelecionado!.codigo} - ${bancoSelecionado!.nome}';
    notifyListeners();
  }

  void limparControladores() {
    controllerAgencia.clear();
    controllerConta.clear();
    controllerValor.clear();
    controllerNome.clear();
    controllerIdBeneficiario.clear();
    controllerBancoSelecionado.clear();
  }

  SolicitarTedParametroModel get parametroSolicitarTed => SolicitarTedParametroModel(valor: valor!, tokenConfirmacao: codigoToken, beneficiario: Beneficiario(codigoBanco: bancoSelecionado!.codigo, agencia: agencia!, numeroConta: conta!, tipoConta: TipoContaEnum.traduzir(tipoContaSelecionada), identificadorBeneficiario: idBeneficiario!, nomeBeneficiario: nome!), informacoesAdicionais: InformacoesAdicionais(codigoFinalidade: '6', descricao: 'teste'), favoritar: false, data: DateTime.now().formatarIso8601);
}
