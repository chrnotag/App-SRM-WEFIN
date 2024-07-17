import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:http/http.dart' as http;

class DeslogarImpl {
  Future<void> deslogar() async {
    Environment ambiente = Modular.get<Environment>();
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'plataforma': ambiente.plataforma.name
    };
    final url = Uri.parse(ambiente.endpoints.login);
    try {
      await http.delete(url, headers: headers);
    } catch (e) {
      return;
    }
  }
}
