import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/api/jadwal_sholat_api.dart';
import 'package:quran/models/jadwal_sholat_model.dart';

final jadwalSholatRiverpod = FutureProvider.family<JadwalSholat, String>(
    (ref, userPlace) => ref.watch(getJadwalApi).getJadwalSholat(userPlace));
