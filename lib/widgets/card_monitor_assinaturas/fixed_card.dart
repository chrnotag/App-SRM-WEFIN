import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';

class FooterFixed extends StatefulWidget {
  final VoidCallback onToggle;

  const FooterFixed({super.key, required this.onToggle});

  @override
  State<FooterFixed> createState() => _FooterFixed();
}

class _FooterFixed extends State<FooterFixed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.r))),
      child: TextButton(
        onPressed: widget.onToggle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ver',
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
