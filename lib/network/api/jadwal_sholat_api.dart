import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/network/models/jadwal_sholat_model.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class JadwalSholatApi {
  Future<JadwalSholat> getJadwalSholat(String userLoc) async {
    try {
      if (userLoc.isNotEmpty) {
        // final url =
        //     Uri.parse('https://api.myquran.com/v2/sholat/kota/cari/$userLoc');
        // final response = await http.get(url);

        // List data = (jsonDecode(response.body) as Map<String, dynamic>)['kota'];
        // final dataId = data.map((e) => e['id']).toList();

        DateTime dateToday = DateTime.now();
        final year = dateToday.year;
        final month = dateToday.month;
        final day = dateToday.day;

        final uri = Uri.parse(
            'https://api.myquran.com/v2/sholat/jadwal/1106/$year/$month/$day');

        final responseData = await http.get(uri);
        Map<String, dynamic> jadwal = (jsonDecode(responseData.body));
        JadwalSholat dataApi = JadwalSholat.fromJson(jadwal);
        return dataApi;
      }
    } catch (e) {
      print(e);
    }

    return getJadwalSholat(userLoc);
  }
}

final getJadwalApi = Provider<JadwalSholatApi>((ref) => JadwalSholatApi());
