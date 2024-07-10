part of '../transferencias_screen.dart';

class _CampoTextoCodigo extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? prevFocusNode;
  final VoidCallback? onFilled;

  const _CampoTextoCodigo({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.prevFocusNode,
    this.onFilled,
  });

  @override
  State<_CampoTextoCodigo> createState() => _CampoTextoCodigoState();
}

class _CampoTextoCodigoState extends State<_CampoTextoCodigo> {
  final Color corVazio = Color(0xffB1B1B1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.12,
      height: 55.h,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: context.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w900),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(
              color: widget.controller.text.isEmpty
                  ? corVazio
                  : Theme.of(context).primaryColor,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (widget.nextFocusNode != null) {
              widget.nextFocusNode!.requestFocus();
            } else {
              widget.onFilled?.call();
            }
          } else if (value.isEmpty) {
            widget.prevFocusNode?.requestFocus();
          }
        },
        maxLength: 1,
      ),
    );
  }
}
