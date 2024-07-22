import 'package:Srm_Asset/core/implementations_config/header_help.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import '../../../../models/conta_digital/bancos/bancos_model.dart';
import '../../../utils/mensagem_erro_requisicao.dart';

class BancosModelImpl {
  static Future<ApiResponse<dynamic>> carregarBancos(String? codigoBanco) async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse(
        '${ambiente.endpoints.listaBancosContaDigital}${codigoBanco != null ? '?codigoBanco=$codigoBanco' : ''}');
    try {
      final response = await http.get(url, headers: header());
      if (response.statusCode == 200) {
        print('lista bancos: ${response.body}');
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = (responseBody as List)
            .map((i) => BancosModel.fromJson(i))
            .toList();
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      print('erro bancos model $e,$s');
      return MensagemErroPadrao.codigo500();
    }
  }
}
