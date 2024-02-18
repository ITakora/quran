import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran/network/models/jadwal_sholat_model.dart';

void main() async {
  final url = Uri.parse('https://api.myquran.com/v2/sholat/kota/cari/serang');
  final response = await http.get(url);

  List data = (jsonDecode(response.body) as Map<String, dynamic>)['data'];

  final dataId = data.map((e) => e['id']).toList();
  print(dataId[1]);
}
