import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quran/network/models/detail_surah_model.dart';

class DetailSurahApi {
  Future<List<DetailSurah>> getDetailSurah({required number}) async {
    final Uri url = Uri.parse('https://equran.id/api/v2/surat/$number');
    final response = await http.get(url);
    final String decodedBody = utf8.decode(response.bodyBytes);
    final List data =
        (jsonDecode(decodedBody) as Map<String, dynamic>)['data']['ayat'];

    final List<DetailSurah> detailSurah =
        data.map((data) => DetailSurah.fromJson(data)).toList();

    return detailSurah;
  }
}

final surahDetailApi = Provider<DetailSurahApi>((ref) => DetailSurahApi());
