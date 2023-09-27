import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/generated/assets.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900, width: 0.5)),
      centerTitle: true,
      title: Image.asset(Assets.imagesLogo, width: 70),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: FloatingActionButton.small(
            onPressed: () =>  Modular.to.navigate(AppRoutes.menuAppRoute),
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
