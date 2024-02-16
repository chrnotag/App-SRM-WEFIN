import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/themes/theme_configs.dart';


extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorScheme => Theme.of(this).colorScheme.primary;
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get onSurface => Theme.of(this).colorScheme.onSurface;
  Color get background => Theme.of(this).colorScheme.background;
  Color get inverseSurface => Theme.of(this).colorScheme.inverseSurface;
  Color get indicatorColor => Theme.of(this).indicatorColor;
  Map<int, Color> get shadersTrust => TrustShades.primaryColor;
  Map<int, Color> get shadersSRM => SRMShaders.primaryColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
  SearchBarThemeData get searchBarTheme  => Theme.of(this).searchBarTheme;
}
