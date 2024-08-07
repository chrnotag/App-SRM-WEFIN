import 'package:json_annotation/json_annotation.dart';

part 'download_boleto_model.g.dart';

@JsonSerializable()
class DownloadBoletoModel {
  final String identificadorSacado;
  final List<String> numerosDocumento;

  DownloadBoletoModel({
    required this.identificadorSacado,
    required this.numerosDocumento,
  });

  factory DownloadBoletoModel.fromJson(Map<String, dynamic> json) =>
      _$DownloadBoletoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadBoletoModelToJson(this);
}