import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:modular_study/generated/assets.dart';

import '../core/constants/themes/theme_configs.dart';

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
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(themeProvider.logoTema, width: 70.w),
            Spacer(),
            Visibility(
              visible: isPerfilVisivel,
              child: InkWell(
                onTap: () => Modular.to.pushNamed(AppRoutes.menuAppRoute),
                  child: Image.asset(
                Assets.iconPerson,
                fit: BoxFit.cover,
                width: 27.r,
              )),
            )
          ],
        ),
      ),
    );
  }
}
