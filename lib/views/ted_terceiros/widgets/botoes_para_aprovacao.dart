import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';

class BotoesAprovarTedTerceiros extends StatelessWidget {
  const BotoesAprovarTedTerceiros({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          BotaoPadrao(label: 'Reprovar', filled: false, onPressed: () {}),
          SizedBox(width: 40.w,),
          BotaoPadrao(label: 'Aprovar', onPressed: () {})
        ],
      ),
    );
  }
}
