import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/network/api/jadwal_sholat_api.dart';
import 'package:quran/network/models/jadwal_sholat_model.dart';

final jadwalSholatRiverpod = FutureProvider.family<JadwalSholat, String>(
    (ref, userPlace) => ref.watch(getJadwalApi).getJadwalSholat(userPlace));
