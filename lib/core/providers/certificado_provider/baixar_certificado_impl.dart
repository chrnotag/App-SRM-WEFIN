import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/certificado_provider.dart';
import 'package:Srm_Asset/main.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import '../../../widgets/dialog_senha_certificado.dart';
import '../../constants/classes_abstratas/envirioment.dart';
import '../../implementations_config/api_response.dart';

class BaixarCertificadoImpl {
  static Future<ApiResponse<dynamic>> baixar(String token) async {
  Environment ambiente = Modular.get<Environment>();
    final header = {
      'accept': 'application/octet-stream',
      'Content-Type': 'application/json'
    };
    final url =
        Uri.parse("${ambiente.endpoints.baixarCertificadoQrCode}/$token");
    final CertificadoProvider provider =
        Modular.get<CertificadoProvider>();
    log('CURL baixar certificado via QrCode:\nheader: $header\nbody: $url ');
    try {
      final content = await http.get(url, headers: header);
      log('Response baixar certificado QrCode: ${content.body}');
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
          onPressed: () => Modular.to.pushNamed(AppRoutes.assinaturaDigitalNavigatorRoute),
        ),
      );
      return SucessResponse(null);
    } catch (e) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
