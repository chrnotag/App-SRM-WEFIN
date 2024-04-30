import 'dart:ffi';

import 'package:Srm_Asset/core/constants/enuns/tipo_operacao_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/utils/money_format.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:flutter/material.dart';

part 'widgets/item_lista_extrato.dart';

part 'widgets/item_lista_operacao.dart';

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
