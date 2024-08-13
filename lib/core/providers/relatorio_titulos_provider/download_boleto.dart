import 'dart:typed_data';

import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/models/relatorio_titulos/download_boleto/download_boleto_model.dart';

import '../../constants/classes_abstratas/envirioment.dart';
import '../../implementations_config/header_help.dart';
import 'package:http/http.dart' as http;

import '../../utils/mensagem_erro_requisicao.dart';

class DownloadBoletoImpl {
  static Future<ApiResponse<dynamic>> baixar(
      DownloadBoletoModel dadosDownload) async {
    final ambiente = Modular.get<Environment>();
    Uri url = Uri.parse(ambiente.endpoints.downloadBoletoRelatorio);
    print(url);
    print(json.encode(dadosDownload.toJson()));

    final List<DownloadBoletoModel> bodyList = [dadosDownload];
    final String bodyJson = json.encode(bodyList.map((e) => e.toJson()).toList());
    try {
      final response = await http.post(url,
          headers: header(), body: bodyJson);
      print(response.body);
      final body = response.bodyBytes;
      if (response.statusCode == 200) {
        final Uint8List pdfBytes = response.bodyBytes;
        return SucessResponse(pdfBytes);
      } else {
        return MensagemErroPadrao.erroResponse(body);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
