import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Map<int, Color> get shadersTrust => TrustShades.primaryColor;
  Map<int, Color> get shadersSRM => SRMShaders.primaryColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
