//Package imports:
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tzinit;
import 'package:timezone/timezone.dart' as tz;

//Project imports:
import '../models/task_model.dart' show TaskModel;

class NotificationsManager {
  static final NotificationsManager _instance = NotificationsManager._();

  factory NotificationsManager() {
    return _instance;
  }

  NotificationsManager._();

  FlutterLocalNotificationsPlugin? _localNotifications;

  Future<void> init() async {
    _localNotifications = FlutterLocalNotificationsPlugin();

    InitializationSettings initializationSettings =
        const InitializationSettings(
          android: AndroidInitializationSettings('app_icon'),
          iOS: DarwinInitializationSettings(),
        );

    await _localNotifications!.initialize(initializationSettings);

    tzinit.initializeTimeZones();
  }

  void requestPermissions() async {
    await Permission.notification.request();
  }

  Future<void> scheduleAlertNotification(TaskModel task) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'high_importance_channel', // ID in Android Manifest
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    DateTime scheduledTime = task.expirationDate!.subtract(
      const Duration(minutes: 30),
    );

    await _localNotifications?.zonedSchedule(
      task.notificationId!,
      task.title,
      'La tarea esta proxima a vencer.¡Tú puedes! Recuerda lo bien que se siente tachar algo de tu lista. ¡La satisfacción te espera!',
      tz.TZDateTime.from(scheduledTime, tz.local), // Hora y zona horaria
      const NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await _localNotifications!.cancel(notificationId);
  }
}
