part of '../menu.dart';

class _MenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuItem(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Icon(widget.icon,
                      color: context.focusColor, size: 25.r),
                ),
                Text(widget.title,
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold,
                        color: themeProvider.isTemaSRM ? AppColors.azul : Colors.black)),
                Expanded(child: Container()),
                Icon(Icons.arrow_forward_ios,
                    color: context.primaryColor, size: 14.r)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
