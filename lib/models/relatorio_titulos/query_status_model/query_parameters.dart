import 'package:Srm_Asset/core/constants/enuns/relatorio_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query_parameters.g.dart';

@JsonSerializable()
class RelatorioQueryParams {
  final String? dataInicialLiquidacao;
  final String? dataFinalLiquidacao;
  final String? dataInicialAVencer;
  final String? dataFinalAVencer;
  final List<RelatorioEnum>? statusRecebiveis;

  RelatorioQueryParams({
    this.dataInicialLiquidacao,
    this.dataFinalLiquidacao,
    this.dataInicialAVencer,
    this.dataFinalAVencer,
    this.statusRecebiveis,
  });

  factory RelatorioQueryParams.fromJson(Map<String, dynamic> json) => _$RelatorioQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RelatorioQueryParamsToJson(this);

  String queryFiltroStatus() {
    final queryString = StringBuffer('?');

    queryString.write('dataInicialLiquidacao=${dataInicialLiquidacao ?? ''}&');
    queryString.write('dataFinalLiquidacao=${dataFinalLiquidacao ?? ''}&');
    queryString.write('dataInicialAVencer=${dataInicialAVencer ?? ''}&');
    queryString.write('dataFinalAVencer=${dataFinalAVencer ?? ''}&');
    if (statusRecebiveis != null && statusRecebiveis!.isNotEmpty) {
      for (var status in statusRecebiveis!) {
        queryString.write('statusRecebiveis=${status.name.toLowerCase()}&');
      }
    }
    // Remove the last '&' if it exists
    final queryStringResult = queryString.toString();
    if (queryStringResult.endsWith('&')) {
      return queryStringResult.substring(0, queryStringResult.length - 1);
    }

    return queryStringResult;
  }

  String queryStatusDownload(){
    final queryString = StringBuffer('?');
    if (statusRecebiveis != null && statusRecebiveis!.isNotEmpty) {
      for (var status in statusRecebiveis!) {
        queryString.write('statusRecebivel=${status.name.toLowerCase()}&');
      }
    }
    final queryStringResult = queryString.toString();
    if (queryStringResult.endsWith('&')) {
      return queryStringResult.substring(0, queryStringResult.length - 1);
    }
    return queryStringResult;
  }
}
