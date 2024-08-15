import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/configs_tema/srm/colors.dart';

class AlertDialogGenerico extends StatefulWidget {
  final String title;
  final String msg;
  final VoidCallback onPressed;
  final Widget? onPressedSecond;

  const AlertDialogGenerico({super.key,
    required this.title,
    required this.msg,
    required this.onPressed,
    this.onPressedSecond,});

  @override
  State<AlertDialogGenerico> createState() => _AlertDialogGenericoState();
}

class _AlertDialogGenericoState extends State<AlertDialogGenerico> {
  final ambiente = Modular.get<Environment>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(ambiente.alerta_icone),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 50.h),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style: context.textTheme
                            .displaySmall!
                            .copyWith(
                            color:
                            SRMColors.textBodyColor,
                            fontWeight:
                            FontWeight.w900),
                      ),
                      Text(
                        widget.msg,
                        style: context.textTheme.bodyLarge!
                            .copyWith(
                            color: context
                                .labelTextColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h,),
                      BotaoPadrao(
                          label: 'Fechar', onPressed: widget.onPressed)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
