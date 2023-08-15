import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/models/detail_surah_model.dart';
import 'package:http/http.dart' as http;

class DetailSurahApi {
  Future<List<DetailSurah>> getDetailSurah({required number}) async {
    final Uri url = Uri.parse('https://equran.id/api/v2/surat/$number');
    final respone = await http.get(url);
    final List data =
        (jsonDecode(respone.body) as Map<String, dynamic>)['data']['ayat'];

    final List<DetailSurah> detailSurah =
        data.map((data) => DetailSurah.fromJson(data)).toList();

    return detailSurah;
  }
}

final surahDetailApi = Provider<DetailSurahApi>((ref) => DetailSurahApi());
