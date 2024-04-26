import 'package:Srm_Asset/generated/assets.dart';
import 'package:flutter/material.dart';

part 'widgets/item_lista_extrato.dart';

part 'widgets/app_bar_extrato.dart';

class TelaExtrato extends StatefulWidget {
  const TelaExtrato({super.key});

  @override
  State<TelaExtrato> createState() => _TelaExtratoState();
}

class _TelaExtratoState extends State<TelaExtrato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: _AppBarExtrato()),
      body: Column(
        children: [
          TabBar(tabs: []),
        ],
      ),
    );
  }
}
