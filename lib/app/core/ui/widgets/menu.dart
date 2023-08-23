import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final IconData iconData;

  const MenuCard({Key? key, required this.iconData}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _IconWithMenuCardState createState() => _IconWithMenuCardState();
}

class _IconWithMenuCardState extends State<MenuCard> {
  bool _showMenu = false;

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleMenu,
          child: Icon(
            widget.iconData,
            size: 35,
          ),
        ),
        if (_showMenu)
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Opção 1'),
                  onTap: () {
                    // Lógica para a opção 1
                  },
                ),
                ListTile(
                  title: const Text('Opção 2'),
                  onTap: () {
                    // Lógica para a opção 2
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Sair'),
                  onTap: _toggleMenu,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ],
            ),
          ),
      ],
    );
  }
}