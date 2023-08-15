import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/models/surah_model.dart';
import 'package:http/http.dart' as http;

class SurahApi {
  Future<List<Surah>> getSurahApi() async {
    final Uri url = Uri.parse('https://equran.id/api/v2/surat/');
    final response = await http.get(url);

    List data = (jsonDecode(response.body) as Map<String, dynamic>)['data'];
    final List<Surah> surahData =
        data.map((data) => Surah.fromJson(data)).toList();

    return surahData;
  }
}

final getSurahApi = Provider<SurahApi>((ref) => SurahApi());
