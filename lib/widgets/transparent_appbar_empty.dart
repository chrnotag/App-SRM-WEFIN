import 'package:flutter/material.dart';

class TransparentAppBarEmpty extends StatelessWidget {
  const TransparentAppBarEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    );
  }
}
