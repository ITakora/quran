import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final int insistentFlag = 4;

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    print("Background tap action ID: ${notificationResponse.actionId}");
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {
        print("Foreground tap payload: ${notificationResponse.payload}");
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    final androidImplementation =
        notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
    }

    List<PendingNotificationRequest> pendingNotifications =
        await notificationsPlugin.pendingNotificationRequests();

    for (PendingNotificationRequest pendingNotification
        in pendingNotifications) {
      print('Pending notification ID: ${pendingNotification.id}');
      print('Notification title: ${pendingNotification.title}');
      print('Notification body: ${pendingNotification.body}');
    }
  }

  tz.TZDateTime _scheduleDaily(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final TimezoneInfo timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName.identifier));
  }

  showNotification(int id, String title, String body, String sound) async {
    await notificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id ',
            'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            actions: <AndroidNotificationAction>[
              const AndroidNotificationAction(
                '1',
                'Stop',
              ),
            ],
            sound: RawResourceAndroidNotificationSound(sound),
            additionalFlags: Int32List.fromList(<int>[insistentFlag]),
            playSound: true,
          ),
          iOS: const DarwinNotificationDetails(),
        ));
  }

  Future<void> cancelNotification({required int id}) async {
    await notificationsPlugin.cancel(id: id);
  }

  scheduledNotification({
    required String title,
    required String body,
    required String sound,
    required int hour,
    required int minutes,
    required int id,
  }) async {
    await notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: _scheduleDaily(hour, minutes),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id ',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          additionalFlags: Int32List.fromList(<int>[insistentFlag]),
          sound: RawResourceAndroidNotificationSound(sound),
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
