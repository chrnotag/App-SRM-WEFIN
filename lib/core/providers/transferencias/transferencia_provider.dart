import 'package:flutter/material.dart';

class TransferenciaProvider extends ChangeNotifier{
  List<String> _itens = [];
  List<String> get itens => _itens;
  set itens (List<String> listaItens) => _itens = listaItens;

  String? _itemSelecionado;
  String? get itemSelecionado => _itemSelecionado;
  set itemSelecionado(String? item) => _itemSelecionado = item;
}