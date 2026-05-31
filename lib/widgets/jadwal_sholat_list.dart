import 'package:flutter/material.dart';
import 'package:quran/network/models/jadwal_sholat_model.dart';
import 'package:quran/services/notification.dart';

class JadwalList extends StatefulWidget {
  const JadwalList({super.key, required this.data});
  final JadwalSholat data;

  @override
  State<JadwalList> createState() => _JadwalListState();
}

class _JadwalListState extends State<JadwalList> {
  final Map<String, bool> _activeNotifications = {
    'Imsak': false,
    'Subuh': false,
    'Dzuhur': false,
    'Ashar': false,
    'Maghrib': false,
    'Isya': false,
  };

  Future<void> _toggleNotification({
    required String name,
    required String timeString,
    required int id,
    required String sound,
    required String body,
  }) async {
    final bool isCurrentlyOn = _activeNotifications[name] ?? false;

    if (isCurrentlyOn) {
      setState(() {
        _activeNotifications[name] = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notifikasi $name dimatikan')),
      );
    } else {
      try {
        List<String> timeParts = timeString.split(':');
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        await NotificationService().scheduledNotification(
            id: id,
            sound: sound,
            title: 'Waktu $name',
            body: body,
            hour: hour,
            minutes: minute);

        setState(() {
          _activeNotifications[name] = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Notifikasi $name dijadwalkan pukul $timeString')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menjadwalkan notifikasi')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jadwal = widget.data.data.jadwal;

    final List<Map<String, dynamic>> items = [
      {
        'name': 'Imsak',
        'time': jadwal.imsak,
        'id': 1,
        'sound': 'adzan_subuh',
        'body': 'Waktu Imsak'
      },
      {
        'name': 'Subuh',
        'time': jadwal.subuh,
        'id': 2,
        'sound': 'adzan_subuh',
        'body': 'Sholat Subuh'
      },
      {
        'name': 'Dzuhur',
        'time': jadwal.dzuhur,
        'id': 3,
        'sound': 'adzan',
        'body': 'Sholat Dzuhur'
      },
      {
        'name': 'Ashar',
        'time': jadwal.ashar,
        'id': 4,
        'sound': 'adzan',
        'body': 'Sholat Ashar'
      },
      {
        'name': 'Maghrib',
        'time': jadwal.maghrib,
        'id': 5,
        'sound': 'adzan',
        'body': 'Sholat Maghrib'
      },
      {
        'name': 'Isya',
        'time': jadwal.isya,
        'id': 6,
        'sound': 'adzan',
        'body': 'Sholat Isya'
      },
    ];

    return Column(
      children: [
        Center(
          child: Text(
            jadwal.tanggal,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        ...items.map((item) {
          final String name = item['name'];
          final bool isOn = _activeNotifications[name] ?? false;

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                '$name :',
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                item['time'],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  isOn
                      ? Icons.notifications_active
                      : Icons.notifications_off_outlined,
                  color: isOn ? Colors.green : Colors.grey,
                  size: 28,
                ),
                onPressed: () => _toggleNotification(
                  name: name,
                  timeString: item['time'],
                  id: item['id'],
                  sound: item['sound'],
                  body: item['body'],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
