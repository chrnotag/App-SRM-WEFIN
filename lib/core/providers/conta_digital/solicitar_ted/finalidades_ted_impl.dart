import 'package:Srm_Asset/core/implementations_config/header_help.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import '../../../../models/conta_digital/finalidades_ted/finalidades_ted_model.dart';
import '../../../utils/mensagem_erro_requisicao.dart';

class FinalidadesTedModelImpl {
  static Future<ApiResponse<dynamic>> pegarFinalidades() async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse(ambiente.endpoints.finalidadesTed);
    try {
      final response = await http.get(url, headers: HeaderPadrao.header());
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = (responseBody as List)
            .map((i) => FinalidadesTedModel.fromJson(i))
            .toList();
        return SucessResponse(data);
      } else {
        print(response.body);
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      print('erro finalidades ted $e,$s');
      return MensagemErroPadrao.codigo500();
    }
  }
}
