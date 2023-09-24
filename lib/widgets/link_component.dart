import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/constants/themes/theme_configs.dart';

class LinkComponent extends StatelessWidget {
  final String label;
  final String route;

  const LinkComponent({super.key, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(route);
      },
      child: Text(
        label,
        style: const TextStyle(color: AppColors.labelText),
      ),
    );
  }
}
