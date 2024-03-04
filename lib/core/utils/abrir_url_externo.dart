import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class AbrirUrl {
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      try {
        await launch(url);
      } catch (_) {}
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }
}
