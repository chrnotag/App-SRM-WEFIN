import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class CustomNotification {
  final int ID;
  final String? title;
  final String? body;
  final String? payload;

  const CustomNotification({
    required this.ID,
    this.title,
    this.body,
    this.payload,
  });
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  late DarwinNotificationDetails iosDetails; // Detalhes específicos da notificação para iOS

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimeZone();
    await _initializeNotifications();
  }

  Future<void> _setupTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = 'America/Sao_Paulo';
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    print('Time zone set to: $timeZoneName');
  }

  Future<void> _initializeNotifications() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    await localNotificationsPlugin.initialize(
      InitializationSettings(
        android: android,
        iOS: iOS,
      ),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    final String? payload = response.payload;
    if (payload != null) {
      print('Notification response received with payload: $payload');
      // Lógica de navegação aqui
      // Navigator.of(navigatorKey.currentContext!).pushNamed('/targetPage', arguments: payload);
    }
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('Local notification received: id=$id, title=$title, body=$body, payload=$payload');
    // Lógica de navegação para notificações recebidas enquanto o app está em primeiro plano no iOS
    // Navigator.of(navigatorKey.currentContext!).pushNamed('/targetPage', arguments: payload);
  }

  checkForNotifications() async {
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      print('App launched by notification with payload: ${details.notificationResponse?.payload}');
      _onDidReceiveNotificationResponse(details.notificationResponse!);
    }
  }

  showNotification(CustomNotification notification) {
    androidDetails = AndroidNotificationDetails(
      'assinatura',
      'Lembretes',
      channelDescription: 'Esta POC é para eu nao ser demitido',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      enableLights: true,
      icon: '@mipmap/ic_launcher',
    );

    androidDetails = AndroidNotificationDetails(
      'ted',
      'Lembretes',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      enableLights: true,
      icon: '@drawable/splash',
      color: TRUSTColors.primaryColor,
    );

    iosDetails = DarwinNotificationDetails(
      sound: 'default',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    localNotificationsPlugin.show(
      notification.ID,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: '/ted',
    );
    print('Notification shown: ID=${notification.ID}, title=${notification.title}, body=${notification.body}');
  }
}
