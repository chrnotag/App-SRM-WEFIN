import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';

class SearchBarPersonalizada extends StatelessWidget {
  final TextEditingController searchController;
  final String hint;
  const SearchBarPersonalizada(
      {super.key, required this.searchController, required this.hint});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchController,
      shape: context.searchBarTheme.shape,
      constraints: context.searchBarTheme.constraints,
      hintText: hint,
      hintStyle: context.searchBarTheme.hintStyle,
      textStyle: context.searchBarTheme.textStyle,
      elevation: MaterialStateProperty.all<double>(0),
      trailing: [
        Icon(
          Icons.search,
          size: 35.r,
          color: Colors.grey,
        )
      ],
    );
  }
}
