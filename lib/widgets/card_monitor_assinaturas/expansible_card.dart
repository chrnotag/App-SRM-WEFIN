import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';

class FooterExpansible extends StatefulWidget {
  final VoidCallback onToggle;
  final bool showInfo;

  const FooterExpansible({super.key, required this.onToggle, required this.showInfo});

  @override
  State<FooterExpansible> createState() => _FooterExpansibleState();
}

class _FooterExpansibleState extends State<FooterExpansible> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.r))),
      child: Column(
        children: [
          Divider(),
          TextButton(
            onPressed: widget.onToggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.showInfo ? 'Menos Detalhes' : 'Mais Detalhes',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
