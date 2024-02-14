import 'package:json_annotation/json_annotation.dart';
part 'documento_model.g.dart';
@JsonSerializable()
class DocumentoModel {
  String url;

  DocumentoModel({required this.url});

  factory DocumentoModel.fromJson(Map<String, dynamic> json) => _$DocumentoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentoModelToJson(this);
}
