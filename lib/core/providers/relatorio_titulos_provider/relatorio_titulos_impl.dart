import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/implementations_config/header_help.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:Srm_Asset/models/relatorio_titulos/relatorio_titulos_model.dart';
import 'package:http/http.dart' as http;

class RelatorioTitulosImpl {
  static pegarTitulos() async {
    final ambiente = Modular.get<Environment>();
    if(ambiente.endpoints.relatorioTitulos != null){
      Uri url = Uri.parse(ambiente.endpoints.relatorioTitulos!);
      try{
        final response = await http.get(url, headers: header());
        final body = response.bodyBytes;
        if(response.statusCode == 200){
          final data = ListaTitulos.fromJson(json.decode(utf8.decode(body)));
          return SucessResponse(data);
        }else{
          return MensagemErroPadrao.erroResponse(body);
        }
      }catch(_){
        return MensagemErroPadrao.codigo500();
      }
    }
  }
}