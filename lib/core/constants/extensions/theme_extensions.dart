import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/imagens_guia_certificado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../configs_tema/export_config_theme_srm.dart';

extension ThemeExtension on BuildContext {
  static final _ambiente = Modular.get<Environment>();
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get primaryColorScheme => Theme.of(this).colorScheme.primary;
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get onSecondaryColor => Theme.of(this).colorScheme.onSecondary;
  Color get onSurfaceColor => Theme.of(this).colorScheme.onSurface;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get inverseSurfaceColor => Theme.of(this).colorScheme.inverseSurface;
  Color get indicatorColor => Theme.of(this).indicatorColor;
  Color get focusColor => Theme.of(this).focusColor;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get successColor => TRUSTColors.primaryColor;
  Color get waitingColor => SRMColors.primaryColor;
  Color get labelTextColor => SRMColors.textLabelColor;
  Color get onBackgroundColor => Theme.of(this).colorScheme.onBackground;
  Color get bordaCardColor => const Color(0XFFDDDDDD);
  ImagensGuiaImportarCertificado get imagensGuiaCertificado => _ambiente.imagensGuiaCertificado;
  TextTheme get textTheme => Theme.of(this).textTheme;
  SearchBarThemeData get searchBarTheme  => Theme.of(this).searchBarTheme;
}
