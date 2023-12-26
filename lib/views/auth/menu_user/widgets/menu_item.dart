part of '../menu.dart';

class _MenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const _MenuItem({Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:5.0),
                  child: Icon(widget.icon,color: isTemaSRM ? AppColors.azul : context.primaryColor,),
                ),
                Text(widget.title,style:context.textTheme.bodyMedium!.copyWith(color: isTemaSRM ? AppColors.corPrimariaSRM : context.shadersTrust[900])),
                Expanded(child: Container()),
                Icon(Icons.arrow_forward_ios, color: isTemaSRM ? AppColors.azul : context.primaryColor,size: AppSizes.paddingMedium)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
