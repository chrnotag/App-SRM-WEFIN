import 'package:url_launcher/url_launcher.dart';

class AbrirUrl{
  static launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }
}