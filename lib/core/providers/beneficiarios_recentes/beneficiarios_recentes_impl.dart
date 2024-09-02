import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/implementations_config/header_help.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:Srm_Asset/models/beneficiarios_recentes/beneficiarios_recentes_model.dart';
import 'package:http/http.dart' as http;

class BeneficiariosRecentesImpl {
  static recentes() async {
    final ambiente = Modular.get<Environment>();
    if (ambiente.endpoints.beneficiariosRecentes != null) {
      Uri url = Uri.parse(ambiente.endpoints.beneficiariosRecentes);
      try {
        final response = await http.get(url, headers: header());
        print(response.body);
        final body = response.bodyBytes;
        if (response.statusCode == 200) {
          final data = (json.decode(utf8.decode(body)) as List)
              .map((item) => BeneficiariosRecentesModel.fromJson(item))
              .toList();
          return SucessResponse(data);
        } else {
          return MensagemErroPadrao.erroResponse(body);
        }
      } catch (_) {
        print(_);
        return MensagemErroPadrao.codigo500();
      }
    }
  }

  static favoritar(BeneficiariosRecentesModel beneficiario) async {
    final ambiente = Modular.get<Environment>();
    final url = Uri.parse(
        '${ambiente.endpoints.beneficiariosRecentes}/${beneficiario.idBeneficiario}/favoritar');
    print('url do favoritar: $url');
    final body = jsonEncode({"favoritar": !beneficiario.favorito});
    print('body: $body');
    try {
      final response = await http.patch(url, body: body, headers: header());
      print(response.body);
      final result = response.bodyBytes;
      if (response.statusCode == 204) {
        return SucessResponse(null);
      } else {
        return MensagemErroPadrao.erroResponse(result);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }
}