import 'package:flutter/material.dart';
import 'package:quran/models/jadwal_sholat_model.dart';
import 'package:quran/services/notification.dart';
import 'package:intl/intl.dart';

class JadwalList extends StatelessWidget {
  const JadwalList({super.key, required this.data});
  final JadwalSholat data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            data.data.tanggal,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              NotificationService().showNotification(
                title: 'Waktu Imsak',
                body: 'Imsak',
              );
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text(
                  'Imsak :',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Text(
                  data.data.imsak,
                  style: const TextStyle(fontSize: 18),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              List<String> timeParts = data.data.subuh.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              DateTime now = DateTime.now();
              DateTime subuhTime =
                  DateTime(now.year, now.month, now.day, hour, minute);

              if (subuhTime.isBefore(now)) {
                subuhTime = subuhTime.add(Duration(days: 1));
              }

              NotificationService().scheduleNotification(
                  title: 'Waktu Dzuhur',
                  body: 'Sholat Dzuhur',
                  scheduledNotificationDateTime: subuhTime);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Subuh :', style: TextStyle(fontSize: 18)),
                trailing: Text(data.data.subuh,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              List<String> timeParts = data.data.dzuhur.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              DateTime now = DateTime.now();
              DateTime dzuhurTime =
                  DateTime(now.year, now.month, now.day, hour, minute);

              if (dzuhurTime.isBefore(now)) {
                dzuhurTime = dzuhurTime.add(Duration(days: 1));
              }

              NotificationService().scheduleNotification(
                  title: 'Waktu Dzuhur',
                  body: 'Sholat Dzuhur',
                  scheduledNotificationDateTime: dzuhurTime);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Dzuhur :', style: TextStyle(fontSize: 18)),
                trailing: Text(data.data.dzuhur,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              List<String> timeParts = data.data.ashar.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              DateTime now = DateTime.now();
              DateTime asharTime =
                  DateTime(now.year, now.month, now.day, hour, minute);

              if (asharTime.isBefore(now)) {
                asharTime = asharTime.add(Duration(days: 1));
              }

              NotificationService().scheduleNotification(
                  title: 'Waktu Ashar',
                  body: 'Sholat Ashar',
                  scheduledNotificationDateTime: asharTime);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Ashar :', style: TextStyle(fontSize: 18)),
                trailing: Text(data.data.ashar,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              List<String> timeParts = data.data.maghrib.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              DateTime now = DateTime.now();
              DateTime maghribTime =
                  DateTime(now.year, now.month, now.day, hour, minute);

              if (maghribTime.isBefore(now)) {
                maghribTime = maghribTime.add(Duration(days: 1));
              }

              NotificationService().scheduleNotification(
                  title: 'Waktu Maghrib',
                  body: 'Sholat Maghrib',
                  scheduledNotificationDateTime: maghribTime);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Maghrib :'),
                trailing: Text(data.data.maghrib,
                    style: const TextStyle(fontSize: 18))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              List<String> timeParts = data.data.isya.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              DateTime now = DateTime.now();
              DateTime isyaTime =
                  DateTime(now.year, now.month, now.day, hour, minute);

              if (isyaTime.isBefore(now)) {
                isyaTime = isyaTime.add(Duration(days: 1));
              }

              NotificationService().scheduleNotification(
                  title: 'Waktu Isya',
                  body: 'Sholat Isya',
                  scheduledNotificationDateTime: isyaTime);
            },
            child: ListTile(
                shape: Border.all(),
                title: const Text('Isya :', style: TextStyle(fontSize: 18)),
                trailing:
                    Text(data.data.isya, style: const TextStyle(fontSize: 18))),
          ),
        ),
      ],
    );
  }
}
