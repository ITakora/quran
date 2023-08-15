import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/models/jadwal_sholat_model.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class JadwalSholatApi {
  Future<JadwalSholat> getJadwalSholat(String userLoc) async {
    final url = Uri.parse(
        'https://api.banghasan.com/sholat/format/json/kota/nama/$userLoc');
    final response = await http.get(url);

    List data = (jsonDecode(response.body) as Map<String, dynamic>)['kota'];
    final dataId = data.map((e) => e['id']).toList();

    DateTime dateToday = DateTime.now();
    String date = dateToday.toString().substring(0, 10);

    final uri = Uri.parse(
        'https://api.banghasan.com/sholat/format/json/jadwal/kota/${dataId[0]}/tanggal/$date');

    final responseData = await http.get(uri);
    Map<String, dynamic> jadwal = (jsonDecode(responseData.body))['jadwal'];
    JadwalSholat dataApi = JadwalSholat.fromJson(jadwal);
    return dataApi;
  }
}

final getJadwalApi = Provider<JadwalSholatApi>((ref) => JadwalSholatApi());
