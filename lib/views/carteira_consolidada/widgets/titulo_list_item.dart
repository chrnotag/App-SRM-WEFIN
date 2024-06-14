part of '../carteira_consolidada_screen.dart';

class _TituloListItem extends StatefulWidget {
  final String label;
  final Widget widgetExpansivel;
  final bool expandir;

  const _TituloListItem(
      {super.key,
      required this.label,
      required this.widgetExpansivel,
      this.expandir = false});

  @override
  State<_TituloListItem> createState() => _TituloListItemState();
}

class _TituloListItemState extends State<_TituloListItem> with SingleTickerProviderStateMixin {
  bool cardExpandido = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.95,
      child: Card(
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
      ),
    );
  }
}

