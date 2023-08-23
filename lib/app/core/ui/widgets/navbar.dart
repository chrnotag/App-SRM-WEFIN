import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/theme/globals.dart';
import 'package:flutter_mobile_project/app/core/ui/widgets/menu.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.globalBackground,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: SizedBox(
        height: kToolbarHeight,
        child: Transform.scale(
          scale: 0.5,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0, top: 10),
          child: MenuCard(iconData: Icons.account_circle), 
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


