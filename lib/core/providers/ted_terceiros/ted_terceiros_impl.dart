import 'dart:typed_data';

import 'package:Srm_Asset/core/constants/enuns/aprovar_ted_enum.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_provider.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:Srm_Asset/models/ted_terceiros/ted_terceiros_model.dart';
import 'package:http/http.dart' as http;
import '../../constants/classes_abstratas/envirioment.dart';
import '../auth_provider_config/logar/auth_providers.dart';

class TedTerceirosImpl {
  static Future<ApiResponse<dynamic>> pegarTransferencias() async {
    final Environment ambiente = Modular.get<Environment>();
    final authProvider = Modular.get<AuthProvider>();
    final tedProvider = Modular.get<TedTerceirosProvider>();
    Uri url = Uri.parse(ambiente.endpoints.listaTransacoesTed);
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        TedTerceirosModel? data;
        data = TedTerceirosModel.fromJson(responseBody);
        data.ordenarTransferencias();
        tedProvider.teds = data;
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e,s) {
      print('erro: $e,$s');
      return MensagemErroPadrao.codigo500();
    }
  }

  static Future<ApiResponse<dynamic>> aprovarOuRecusar(
      AprovarTedEnum aprovarTedEnum, int codigoTransferencia) async {
    final Environment ambiente = Modular.get<Environment>();
    final authProvider = Modular.get<AuthProvider>();
    final tedProvider = Modular.get<TedTerceirosProvider>();
    Uri url = ambiente.endpoints
        .montarUrlAprovacaoTed(aprovarTedEnum, '$codigoTransferencia');
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        Transferencia? data;
        data = Transferencia.fromJson(responseBody);
        tedProvider.transferencia = data;
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }

  static Future<ApiResponse<dynamic>> downloadComprovante(
      String codigoTransacao) async {
    final Environment ambiente = Modular.get<Environment>();
    final authProvider = Modular.get<AuthProvider>();
    final tedProvider = Modular.get<TedTerceirosProvider>();
    Uri url =
        ambiente.endpoints.montarUrlDownloadComprovanteTED('$codigoTransacao');
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    try {
      final response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final Uint8List pdfBytes = response.bodyBytes;
        tedProvider.pdfComprovante = pdfBytes;
        return SucessResponse(pdfBytes);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
