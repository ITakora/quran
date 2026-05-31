import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/network/models/jadwal_sholat_model.dart';
import 'package:quran/riverpods/notification_riverpod.dart';

class JadwalList extends ConsumerWidget {
  const JadwalList({super.key, required this.data});
  final JadwalSholat data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jadwal = data.data.jadwal;
    final notifState = ref.watch(notificationProvider);
    final notifNotifier = ref.read(notificationProvider.notifier);

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
          final bool isOn = notifState[name] ?? false;

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text('$name :', style: const TextStyle(fontSize: 18)),
              subtitle:
                  Text(item['time'], style: const TextStyle(fontSize: 16)),
              trailing: IconButton(
                icon: Icon(
                  isOn
                      ? Icons.notifications_active
                      : Icons.notifications_off_outlined,
                  color: isOn ? Colors.green : Colors.grey,
                  size: 28,
                ),
                onPressed: () => notifNotifier.toggle(
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
