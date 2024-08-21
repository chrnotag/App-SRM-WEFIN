import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../notifications/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessaginService {
  final NotificationService _notificationService;

  const FirebaseMessaginService(this._notificationService);

  // Inicializa as opções de notificação e configura listeners
  Future<void> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );

    // Obter e imprimir o token do dispositivo
    getDeviceFirebaseToken();

    // Listeners para notificações em diferentes estados do app
    _onMessage();
    _onMessageOpenedApp();
    _onBackgroundMessage();
  }

  // Obtém e imprime o token do dispositivo
  void getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    final authProvider = Modular.get<AuthProvider>();
    authProvider.tokenNotificacao = token;
    debugPrint("==================");
    debugPrint("TOKEN: $token");
    debugPrint("==================");
  }

  // Listener para mensagens recebidas enquanto o app está em primeiro plano
  void _onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: ${message.notification?.title}, ${message.notification?.body}');
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // AppleNotification? apple = message.notification?.apple;

      if (notification != null) {
        _notificationService.showNotification(
          CustomNotification(
            ID: notification.hashCode,
            title: notification.title!,
            body: notification.body!,
          ),
        );
      }
    });
  }

  // Listener para quando o app é aberto a partir de uma notificação
  void _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: ${message.notification?.title}, ${message.notification?.body}');
      _goToPageAfterMessaging(message);
    });
  }

  // Navega para uma página específica após receber uma mensagem
  void _goToPageAfterMessaging(RemoteMessage message) {
    final String route = message.data['route'] ?? '';
    print('Navigating to route: $route');
    if (route.isNotEmpty) {
      //navigatorKey.currentState?.pushNamed(route);
    }
  }

  // Listener para mensagens recebidas enquanto o app está em segundo plano
  void _onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Handler para mensagens recebidas em segundo plano
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_message', message.data.toString());
    print("Handling a background message: ${message.messageId}");
  }
}