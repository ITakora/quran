import 'package:flutter/material.dart';
import 'package:quran/network/models/jadwal_sholat_model.dart';
import 'package:quran/services/notification.dart';

class JadwalList extends StatelessWidget {
  const JadwalList({super.key, required this.data});
  final JadwalSholat data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            data.data.jadwal.tanggal,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              await NotificationService()
                  .showNotification(0, 'Waktu Imsak', 'Waktu Imsak', 'adzan');
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text(
                  'Imsak :',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Text(
                  data.data.jadwal.imsak,
                  style: const TextStyle(fontSize: 18),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              List<String> timeParts = data.data.jadwal.subuh.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              await NotificationService().scheduledNotification(
                  id: 1,
                  sound: 'adzan_subuh',
                  title: 'Waktu Subuh',
                  body: 'Sholat Subuh',
                  hour: hour,
                  minutes: minute);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Subuh :', style: TextStyle(fontSize: 18)),
                trailing: Text(data.data.jadwal.subuh,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              List<String> timeParts = data.data.jadwal.dzuhur.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              await NotificationService().scheduledNotification(
                  id: 2,
                  sound: 'adzan',
                  title: 'Waktu Dzuhur',
                  body: 'Sholat Dzuhur',
                  hour: hour,
                  minutes: minute);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Dzuhur :', style: TextStyle(fontSize: 18)),
                trailing: Text(data.data.jadwal.dzuhur,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              List<String> timeParts = data.data.jadwal.ashar.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              await NotificationService().scheduledNotification(
                  id: 3,
                  sound: 'adzan',
                  title: 'Waktu Ashar',
                  body: 'Sholat Ashar',
                  hour: hour,
                  minutes: minute);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Ashar :', style: TextStyle(fontSize: 18)),
                trailing: Text(data.data.jadwal.ashar,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              List<String> timeParts = data.data.jadwal.maghrib.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              await NotificationService().scheduledNotification(
                  id: 4,
                  sound: 'adzan',
                  title: 'Waktu Maghrib',
                  body: 'Sholat Maghrib',
                  hour: hour,
                  minutes: minute);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Maghrib :'),
                trailing: Text(data.data.jadwal.maghrib,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              List<String> timeParts = data.data.jadwal.isya.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              await NotificationService().scheduledNotification(
                  id: 5,
                  sound: 'adzan',
                  title: 'Waktu Isya',
                  body: 'Sholat Isya',
                  hour: hour,
                  minutes: minute);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Isya :', style: TextStyle(fontSize: 18)),
                trailing: Text(data.data.jadwal.isya,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
      ],
    );
  }
}
