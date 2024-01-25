import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/network/api/surah_api.dart';

import 'package:quran/network/models/surah_model.dart';

final surahRiverpod = FutureProvider<List<Surah>>(
  (ref) => ref.watch(getSurahApi).getSurahApi(),
);
