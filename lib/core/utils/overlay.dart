import 'package:flutter/material.dart';

import '../../widgets/loader_widget.dart';

class OverlayApp {
  static final _overlayLoader = OverlayEntry(
    builder: (context) => const Material(
      color: Colors.transparent,
      child: Loader(),
    ),
  );

  static iniciaOverlay(BuildContext context) {
    Overlay.of(context).insert(_overlayLoader);
  }

  static terminaOverlay() {
    _overlayLoader.remove();
  }
}
