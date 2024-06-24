import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';

class BotaoComprovanteTedTerceiros extends StatelessWidget {
  const BotaoComprovanteTedTerceiros({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: 330.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BotaoPadrao(label: 'Comprovante', filled: true, onPressed: () {})
          ],
        ),
      ),
    );
  }
}
