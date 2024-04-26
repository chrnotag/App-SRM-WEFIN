part of '../tela_extrato.dart';

class _ItemListaExtrato extends StatelessWidget {
  final String tituloTransferencia;
  final String autor;
  final String valor;
  final String data;

  const _ItemListaExtrato(
      {super.key,
      required this.tituloTransferencia,
      required this.autor,
      required this.valor,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(tituloTransferencia),
          Text(valor)
        ],
      ),
      subtitle: Row(
        children: [
          Text(autor),
          Text(data)
        ],
      ),
    );
  }
}
