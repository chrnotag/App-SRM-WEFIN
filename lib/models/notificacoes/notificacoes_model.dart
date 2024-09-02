import 'package:json_annotation/json_annotation.dart';

part 'notificacoes_model.g.dart';

@JsonSerializable()
class NotificacoesModel {
  String titulo;
  String mensagem;
  bool lido;
  DateTime dataNotificacao;
  int idNotificacao;
  String nomeCanal;

  NotificacoesModel({
    required this.titulo,
    required this.mensagem,
    required this.lido,
    required this.dataNotificacao,
    required this.idNotificacao,
    required this.nomeCanal,
  });

  factory NotificacoesModel.fromJson(Map<String, dynamic> json) =>
      _$NotificacoesModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificacoesModelToJson(this);
}
