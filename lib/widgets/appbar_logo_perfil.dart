import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';
import 'package:Srm_Asset/generated/assets.dart';

import '../core/constants/environment/homologacao/srm/tema_configs.dart';

class AppBarLogo extends StatelessWidget {
  final bool isPerfilVisivel;

  const AppBarLogo({super.key, this.isPerfilVisivel = true});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    return AppBar(
      iconTheme: IconThemeData(color: context.onSecondary, size: 25.r),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Image.asset(themeProvider.logoTemaAppBar, width: 70.w),
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
                color: themeProvider.isTemaSRM ? Colors.white : AppColors.verdePrimarioTRUST,
                width: 27.r,
              ),
            ),
          ),
        )
      ],
    );
  }
}
