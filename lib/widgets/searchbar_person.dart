import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/theme_provider.dart';

import '../core/constants/enuns/theme_enum.dart';
import '../core/constants/themes/theme_configs.dart';

class SearchBarPersonalizada extends StatelessWidget {
  final TextEditingController searchController;
  final String hint;
  const SearchBarPersonalizada(
      {super.key, required this.searchController, required this.hint});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    return SearchBar(
      controller: searchController,
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: themeProvider.temaSelecionado == TemaSelecionado.SRM ? BorderSide.none : BorderSide(color: context.primaryColor))),
      constraints: BoxConstraints.expand(width: double.infinity, height: 35),
      hintText: hint,
      hintStyle: MaterialStateProperty.all<TextStyle>(
          context.textTheme.bodySmall!.copyWith(color: AppColors.labelText)),
      textStyle: MaterialStateProperty.all<TextStyle>(context.textTheme.bodySmall!),
      elevation: MaterialStateProperty.all<double>(0),
      trailing: [
        Icon(
          Icons.search,
        )
      ],
    );
  }
}
