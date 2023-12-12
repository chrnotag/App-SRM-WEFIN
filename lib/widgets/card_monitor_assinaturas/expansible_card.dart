import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';

class FooterExpansible extends StatefulWidget {
  final VoidCallback onToggle;

  const FooterExpansible({super.key, required this.onToggle});

  @override
  State<FooterExpansible> createState() => _FooterExpansibleState();
}

class _FooterExpansibleState extends State<FooterExpansible> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xffFAFAFA),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5))),
      child: TextButton(
        onPressed: widget.onToggle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mais Detalhes',
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
