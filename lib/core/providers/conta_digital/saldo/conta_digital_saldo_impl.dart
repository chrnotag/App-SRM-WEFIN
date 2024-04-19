import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/models/conta_digital/saldo/saldo_conta_digital.dart';
import 'package:http/http.dart' as http;
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../../auth_provider_config/logar/auth_providers.dart';

class ContaDigitalSaldoImpl{
  static Future<ApiResponse<dynamic>> resgatarSaldo(String numeroContaTitular) async {
    final authProvider = Modular.get<AuthProvider>();
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse("${ambiente.endpoints.saldoContaDigital}?numeroContaTitular=${numeroContaTitular}");
    print('url: $url');
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    try {
      final response = await http.get(url, headers: headers);
      print('CURL:\nURL: $url\nHeaders: $headers\no que recebo: ${response.body}');
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = SaldoContaDigitalModel.fromJson(responseBody);
        return SucessResponse(data);
      } else if (response.statusCode == 500) {
        print('teste2');
        return MensagemErroPadrao.codigo500();
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      print('teste3, $e,$s');
      return MensagemErroPadrao.codigo500();
    }
  }
}