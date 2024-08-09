import 'dart:typed_data';
import 'package:Srm_Asset/core/constants/enuns/relatorio_enum.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/models/relatorio_titulos/query_status_model/query_parameters.dart';
import 'package:http/http.dart' as http;
import '../../constants/classes_abstratas/envirioment.dart';
import '../../implementations_config/header_help.dart';
import '../../utils/mensagem_erro_requisicao.dart';

class DownloadRelatorioImpl {
  static baixar(RelatorioQueryParams params) async {
    final ambiente = Modular.get<Environment>();
    if(ambiente.endpoints.relatorioTitulos != null){
      Uri url = Uri.parse('${ambiente.endpoints.downloadRelatorioTitulos}${params.queryStatusDownload()}');
      print(params.queryStatusDownload());
      print(url);
      try{
        final response = await http.get(url, headers: header());
        print(response.body);
        final body = response.bodyBytes;
        if(response.statusCode == 200){
          final Uint8List pdfBytes = response.bodyBytes;
          return SucessResponse(pdfBytes);
        }else{
          return MensagemErroPadrao.erroResponse(body);
        }
      }catch(_){
        return MensagemErroPadrao.codigo500();
      }
    }
  }
}
