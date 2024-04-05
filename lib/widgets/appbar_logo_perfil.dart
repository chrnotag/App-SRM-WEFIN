import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/generated/assets.dart';

import '../core/constants/tema_configs.dart';
import '../core/utils/ambiente_atual.dart';

class AppBarLogo extends StatelessWidget {
  final bool isPerfilVisivel;

  const AppBarLogo({super.key, this.isPerfilVisivel = true});

  @override
  Widget build(BuildContext context) {
  Environment ambiente = Modular.get<Environment>();
    return AppBar(
      iconTheme: IconThemeData(color: context.onSecondary, size: 25.r),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Image.asset(ambiente.logoAppBar, width: 70.w),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.h),
          child: Visibility(
            visible: isPerfilVisivel,
            child: InkWell(
              onTap: () => Modular.to.pushNamed(AppRoutes.menuAppRoute),
              child: Image.asset(
                Assets.iconPerson,
                fit: BoxFit.cover,
                color: VerificarAmbiente.isSRM ? Colors.white : AppColors.verdePrimarioTRUST,
                width: 27.r,
              ),
            ),
          ),
        )
      ],
    );
  }
}
