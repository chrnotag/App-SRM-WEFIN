import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class TituloListItemInterno extends StatefulWidget {
  final String label;
  final Widget widgetExpansivel;
  final bool expandir;

  const TituloListItemInterno(
      {super.key,
      required this.label,
      required this.widgetExpansivel,
      this.expandir = false});

  @override
  State<TituloListItemInterno> createState() => _TituloListItemInternoState();
}

class _TituloListItemInternoState extends State<TituloListItemInterno> with SingleTickerProviderStateMixin {
  bool cardExpandido = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.95,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.label,
                      style: context.textTheme.displaySmall!
                          .copyWith(fontWeight: FontWeight.w600, color: context.labelTextColor),
                    ),
                  ),
                  IconButton(
                    icon: Icon(cardExpandido ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                    color: context.primaryColor,
                    onPressed: () {
                      setState(() {
                        cardExpandido = !cardExpandido;
                      });
                    },
                  )
                ],
              ),
            ),
            if (cardExpandido) widget.widgetExpansivel,
          ],
        ),
      ),
    );
  }
}

