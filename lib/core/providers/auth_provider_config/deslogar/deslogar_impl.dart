import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:http/http.dart' as http;

class DeslogarImpl {
  Future<void> deslogar() async {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'plataforma': themeProvider.temaSelecionado.name
    };
    final url = Uri.parse(EndPoints.login);
    try {
      await http.delete(url, headers: headers);
    } catch (e) {
      Fluttertoast.showToast(msg: "Erro: $e, por favor, tente novamente");
    }
  }
}
