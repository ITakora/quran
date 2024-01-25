import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/network/api/surah_detail_api.dart';
import 'package:quran/network/models/detail_surah_model.dart';

final detailSurahRiverpod = FutureProvider.family<List<DetailSurah>, int?>(
    (ref, number) => ref.watch(surahDetailApi).getDetailSurah(number: number));
