import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/carteira_aberto/carteira_aberto_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/prazo_liquidez/prazo_liquidez_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_provider.dart';
import 'package:Srm_Asset/models/carteira_consolidada/carteira_aberto/carteira_aberto_model.dart';
import 'package:Srm_Asset/models/carteira_consolidada/prazo_liquidez/prazo_liquidez_model.dart';
import 'package:Srm_Asset/models/carteira_consolidada/recebiveis/recebiveis_model.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../../auth_provider_config/logar/auth_providers.dart';
import 'package:http/http.dart' as http;

class RecebiveisImpl {
  static Future<ApiResponse<dynamic>> pegarDados() async {
    final Environment ambiente = Modular.get<Environment>();
    final authProvider = Modular.get<AuthProvider>();
    Uri url = Uri.parse(ambiente.endpoints.carteiraRecebiveis);
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    final recebiveisProvider = Modular.get<RecebiveisProvider>();
    try {
      final response = await http.get(url, headers: headers);
      print('response: ${response.body}');
      if (response.statusCode == 200) {
        final data = RecebiveisModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        recebiveisProvider.recebiveis = data;
        return SucessResponse(data);
      } else if (response.statusCode == 500) {
        return MensagemErroPadrao.codigo500();
      } else {
        print('erro');
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      print("$e, $s");
      return MensagemErroPadrao.codigo500();
    }
  }
}
