import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';

import '../core/constants/themes/theme_configs.dart';

class SearchBarPersonalizada extends StatelessWidget {
  final TextEditingController searchController;
  final String hint;
  const SearchBarPersonalizada(
      {super.key, required this.searchController, required this.hint});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchController,
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide.none)),
      constraints: BoxConstraints.expand(width: double.infinity, height: 35),
      hintText: hint,
      hintStyle: MaterialStateProperty.all<TextStyle>(
          context.textTheme.bodySmall!.copyWith(color: AppColors.labelText)),
      elevation: MaterialStateProperty.all<double>(0),
      trailing: [
        Icon(
          Icons.search,
        )
      ],
    );
  }
}
