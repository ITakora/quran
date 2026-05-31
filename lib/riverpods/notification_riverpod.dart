import 'package:flutter_riverpod/legacy.dart';
import 'package:quran/services/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

final notificationProvider =
    StateNotifierProvider<JadwalNotificationNotifier, Map<String, bool>>((ref) {
  return JadwalNotificationNotifier();
});

class JadwalNotificationNotifier extends StateNotifier<Map<String, bool>> {
  JadwalNotificationNotifier()
      : super({
          'Imsak': false,
          'Subuh': false,
          'Dzuhur': false,
          'Ashar': false,
          'Maghrib': false,
          'Isya': false,
        }) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = {
      for (final name in state.keys)
        name: prefs.getBool('notif_$name') ?? false,
    };
  }

  Future<void> toggle({
    required String name,
    required String timeString,
    required int id,
    required String sound,
    required String body,
  }) async {
    final isCurrentlyOn = state[name] ?? false;
    final prefs = await SharedPreferences.getInstance();

    if (isCurrentlyOn) {
      await NotificationService().cancelNotification(id: id);
      await prefs.setBool('notif_$name', false);
      state = {...state, name: false};
    } else {
      try {
        final timeParts = timeString.split(':');
        await NotificationService().scheduledNotification(
          id: id,
          sound: sound,
          title: 'Waktu $name',
          body: body,
          hour: int.parse(timeParts[0]),
          minutes: int.parse(timeParts[1]),
        );
        await prefs.setBool('notif_$name', true);
        state = {...state, name: true};
      } catch (e) {}
    }
  }

  Future<void> rescheduleAll(Map<String, Map<String, dynamic>> timeMap) async {
    for (final entry in state.entries) {
      if (entry.value == true) {
        try {
          final item = timeMap[entry.key]!;
          final timeParts = (item['time'] as String).split(':');
          await NotificationService().scheduledNotification(
            id: item['id'] as int,
            sound: item['sound'] as String,
            title: 'Waktu ${entry.key}',
            body: item['body'] as String,
            hour: int.parse(timeParts[0]),
            minutes: int.parse(timeParts[1]),
          );
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
