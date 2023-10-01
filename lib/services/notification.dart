import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:audioplayers/audioplayers.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final int insistentFlag = 4;

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    print(notificationResponse.actionId);
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {},
    );

    List<PendingNotificationRequest> pendingNotifications =
        await notificationsPlugin.pendingNotificationRequests();

    for (PendingNotificationRequest pendingNotification
        in pendingNotifications) {
      print('Pending notification ID: ${pendingNotification.id}');
      print('Notification title: ${pendingNotification.title}');
      print('Notification body: ${pendingNotification.body}');
    }
  }

  // notificationDetails() {
  //   return
  // }

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
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  showNotification(int id, String title, String body, String sound) async {
    // await player.play(AssetSource('sound/adzan.mp3'));

    notificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id ',
            'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            actions: <AndroidNotificationAction>[
              AndroidNotificationAction(
                '1',
                'Stop',
              ),
            ],
            sound: RawResourceAndroidNotificationSound('$sound'),
            additionalFlags: Int32List.fromList(<int>[insistentFlag]),
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(),
        ));
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
      id,
      title,
      body,
      _scheduleDaily(hour, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id ',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          additionalFlags: Int32List.fromList(<int>[insistentFlag]),
          sound: RawResourceAndroidNotificationSound('$sound'),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
