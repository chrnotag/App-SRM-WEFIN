import 'package:flutter/material.dart';

class LinkComponent extends StatelessWidget {
  final String label;
  final String route;

  const LinkComponent({super.key, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: {});
      },
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
