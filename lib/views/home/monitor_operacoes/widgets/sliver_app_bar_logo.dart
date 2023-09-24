import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';

import '../../../../generated/assets.dart';

class SliverAppBarLogo extends StatelessWidget {
  const SliverAppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppColors.globalBackground,
      shadowColor: Colors.transparent,
      shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900, width: 0.5)),
      centerTitle: true,
      title: Image.asset(Assets.imagesLogo, width: 70),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: FloatingActionButton.small(
            onPressed: () {},
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: const BorderSide(color: Colors.white, width: 0.5)),
            child: const Icon(Icons.perm_identity, size: 30),
          ),
        )
      ],
    );
  }
}
