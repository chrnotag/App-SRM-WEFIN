import 'package:flutter/material.dart';

import '../generated/assets.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Image.asset(Assets.imgLoading),
        ),
      ),
    );
  }
}
