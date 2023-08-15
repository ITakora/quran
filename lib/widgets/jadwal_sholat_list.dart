import 'package:flutter/material.dart';
import 'package:quran/models/jadwal_sholat_model.dart';

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              shape: Border.all(),
              title: const Text('Subuh :', style: TextStyle(fontSize: 18)),
              trailing:
                  Text(data.data.subuh, style: const TextStyle(fontSize: 18))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              shape: Border.all(),
              title: const Text('Dzuhur :', style: TextStyle(fontSize: 18)),
              trailing:
                  Text(data.data.dzuhur, style: const TextStyle(fontSize: 18))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              shape: Border.all(),
              title: const Text('Ashar :', style: TextStyle(fontSize: 18)),
              trailing:
                  Text(data.data.ashar, style: const TextStyle(fontSize: 18))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              shape: Border.all(),
              title: const Text('Maghrib :'),
              trailing: Text(data.data.maghrib,
                  style: const TextStyle(fontSize: 18))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              shape: Border.all(),
              title: const Text('Isya :', style: TextStyle(fontSize: 18)),
              trailing:
                  Text(data.data.isya, style: const TextStyle(fontSize: 18))),
        ),
      ],
    );
  }
}
