import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/network/api/doa_api.dart';
import 'package:quran/network/models/doa_list_model.dart';

final doaListRiverpod =
    FutureProvider<List<Doa>>((ref) => ref.watch(getDoaApi).getDoaApi());
