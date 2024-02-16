import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:Srm_Asset/main.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import '../../../widgets/dialog_senha_certificado.dart';
import '../../implementations_config/api_response.dart';

class BaixarCertificadoImpl {
  static Future<ApiResponse<dynamic>> baixar(String token) async {
    final header = {
      'accept': 'application/octet-stream',
      'Content-Type': 'application/json'
    };
    final url =
        Uri.parse("${EndPoints.baixarArquivo}/${Uri.encodeComponent(token)}");
    final ImportarCertificadoProvider provider =
        Modular.get<ImportarCertificadoProvider>();
    try {
      final content = await http.get(url, headers: header);
      if (content.statusCode == 200) {
        provider.pkcs12 = content.bodyBytes;
        showDialog(
          context: myNavigatorKey.currentState!.context,
          builder: (context) => const DialogSenhaCertificado(),
        );
        return SucessResponse(null);
      }
      showDialog(
        context: myNavigatorKey.currentState!.context,
        builder: (context) => AlertDialogGenerico(
          title: 'Erro',
          msg: 'Não foi possivel baixar o certificado, tente novamente.',
          onPressed: () => Modular.to.pushNamed(AppRoutes.leitorQrCodeRoute),
        ),
      );
      return SucessResponse(null);
    } catch (e) {
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, algo deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
