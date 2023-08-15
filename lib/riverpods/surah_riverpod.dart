import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/api/surah_api.dart';

import 'package:quran/models/surah_model.dart';

final surahRiverpod = FutureProvider<List<Surah>>(
  (ref) => ref.watch(getSurahApi).getSurahApi(),
);
