part of '../menu.dart';

class _ItemMenu extends StatefulWidget {
  final String title;
  final String content;

  const _ItemMenu({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  _ItemMenuState createState() => _ItemMenuState();
}

class _ItemMenuState extends State<_ItemMenu> {
  @override
  Widget build(BuildContext context) {
    Environment ambiente = Modular.get<Environment>();
    return Column(
      children: [
        Text(
          widget.title,
          style: context.textTheme.bodyMedium,
        ),
        Text(
          widget.content,
          style: context.textTheme.bodyLarge!
              .copyWith(color: SRMColors.textBodyColor, fontWeight: FontWeight.w900,),
        ),
      ],
    );
  }
}
