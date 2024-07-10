
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';

class ItemCardTed extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? cnpjFormatter;
  const ItemCardTed({super.key, required this.title, this.content, this.cnpjFormatter});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyMedium,),
        cnpjFormatter != null ? cnpjFormatter! : Text(
          content!,
          style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w900),
        )
      ],
    );
  }
}
