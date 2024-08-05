import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:Srm_Asset/main.dart';

// Objeto de notificação
class CustomNotification {
  final int ID; // Identificador único da notificação
  final String? title; // Título da notificação
  final String? body; // Corpo da mensagem da notificação
  final String? payload; // Informação adicional da notificação

  const CustomNotification(
      {required this.ID, this.title, this.body, this.payload});
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin; // Plugin para gerenciar notificações locais
  late AndroidNotificationDetails androidDetails; // Detalhes específicos da notificação para Android

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin(); // Inicializa o plugin de notificações
    _setupNotifications(); // Configura as notificações
  }

  // Método privado para configurar as notificações
  _setupNotifications() async {
    await _setupTimeZone(); // Configura o fuso horário
    await _initializeNotifications(); // Inicializa o plugin de notificações
  }

  // Método assíncrono para configurar o fuso horário
  Future<void> _setupTimeZone() async {
    tz.initializeTimeZones(); // Inicializa as zonas de tempo
    final String timeZoneName = 'America/Sao_Paulo'; // Define o fuso horário padrão
    tz.setLocalLocation(tz.getLocation(timeZoneName)); // Define a localização do fuso horário
    print('Time zone set to: $timeZoneName'); // Imprime a zona de tempo configurada
  }

  // Método assíncrono para inicializar as notificações
  Future<void> _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher'); // Configurações iniciais para Android
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse, // Define o callback para quando uma notificação é recebida
    );
  }

  // Callback para lidar com a resposta à notificação
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    final String? payload = response.payload; // Obtém o payload da notificação
    if (payload != null) {
      print('notification payload: $payload'); // Imprime o payload da notificação
      // Lógica de navegação aqui
      // Navegar para a tela desejada usando o Navigator
      //Navigator.of(navigatorKey.currentContext!).pushNamed('/targetPage', arguments: payload); // Navega para a página de destino com o payload
    }
  }

  // Método para verificar se o aplicativo foi lançado a partir de uma notificação
  checkForNotifications() async {
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails(); // Obtém detalhes do lançamento do aplicativo
    if (details != null && details.didNotificationLaunchApp) {
      _onDidReceiveNotificationResponse(details.notificationResponse!); // Lida com a resposta à notificação
    }
  }

  // Método para mostrar uma notificação
  showNotification(CustomNotification notification) {
    androidDetails = AndroidNotificationDetails(
        'assinatura', // ID do canal
        'Lembretes', // Nome do canal
        channelDescription: 'Esta POC é para eu nao ser demitido', // Descrição do canal
        importance: Importance.max, // Importância máxima da notificação
        priority: Priority.max, // Prioridade máxima da notificação
        enableVibration: true, // Habilita vibração
        enableLights: true, // Habilita luzes
        icon: '@mipmap/ic_launcher' // Ícone da notificação
    );

    androidDetails = AndroidNotificationDetails(
        'ted', // ID do canal
        'Lembretes', // Nome do canal
        importance: Importance.max, // Importância máxima da notificação
        priority: Priority.max, // Prioridade máxima da notificação
        enableVibration: true, // Habilita vibração
        enableLights: true, // Habilita luzes
        icon: '@mipmap/ic_launcher' // Ícone da notificação
    );
    localNotificationsPlugin.show(
      notification.ID, // ID da notificação
      notification.title, // Título da notificação
      notification.body, // Corpo da mensagem da notificação
      NotificationDetails(android: androidDetails), // Detalhes da notificação para Android
      payload: '/ted', // Payload da notificação
    );
  }
}


