// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran/models/jadwal_sholat_model.dart';

main() async {
  final url = Uri.parse(
      'https://api.banghasan.com/sholat/format/json/kota/nama/kota serang');
  final response = await http.get(url);

  List data = (jsonDecode(response.body) as Map<String, dynamic>)['kota'];
  final dataId = data.map((e) => e['id']).toList();

  DateTime dateToday = DateTime.now();
  String date = dateToday.toString().substring(0, 10);

  final uri = Uri.parse(
      'https://api.banghasan.com/sholat/format/json/jadwal/kota/${dataId[0]}/tanggal/$date');

  final responseData = await http.get(uri);
  Map<String, dynamic> jadwal =
      (jsonDecode(responseData.body) as Map<String, dynamic>)['jadwal'];
  JadwalSholat jadwalDataApi = JadwalSholat.fromJson(jadwal);
  print(jadwalDataApi.data.dzuhur);
}
