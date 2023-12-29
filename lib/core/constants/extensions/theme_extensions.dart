import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';


extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorScheme => Theme.of(this).colorScheme.primary;
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get onSurface => Theme.of(this).colorScheme.onSurface;
  Color get background => Theme.of(this).colorScheme.background;
  Map<int, Color> get shadersTrust => TrustShades.primaryColor;
  Map<int, Color> get shadersSRM => SRMShaders.primaryColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
