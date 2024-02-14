import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class AbrirPastasSistema {
  static void navegar(String path) {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull(path),
      type: 'resource/folder',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );

    intent.launch().catchError((e) {
      print(e.toString());
    });
  }
}
