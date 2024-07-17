import 'dart:typed_data';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_provider.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../../auth_provider_config/logar/auth_providers.dart';
import 'package:http/http.dart' as http;

class DownloadRecebiveisImpl {
  static Future<ApiResponse<dynamic>> baixar() async {
    final Environment ambiente = Modular.get<Environment>();
    final authProvider = Modular.get<AuthProvider>();
    final recebiveisProvider = Modular.get<RecebiveisProvider>();
    Uri url = Uri.parse(ambiente.endpoints.downloadRecebiveis);
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final Uint8List pdfBytes = response.bodyBytes;
        recebiveisProvider.pdfRecebiveis = pdfBytes;
        return SucessResponse(pdfBytes);
      } else if (response.statusCode == 500) {
        return MensagemErroPadrao.codigo500();
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }
}