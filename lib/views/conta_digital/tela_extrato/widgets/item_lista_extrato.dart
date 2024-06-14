import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/data_format.dart';
class ItemListaExtrato extends StatelessWidget {
  final String dataDia;
  final String saldoDia;

  const ItemListaExtrato({
    super.key,
    required this.dataDia,
    required this.saldoDia,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        FormatarData.formatarExtenso(DateTime.parse(dataDia)),
        style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w900),
      ),
      subtitle: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Saldo do dia:'),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.r),
                      ),
                      color: Colors.grey.shade300),
                  child: Text(
                    saldoDia,
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
          Divider(color: context.labelTextColor, thickness: 0.2)
        ],
      ),
    );
  }
}
