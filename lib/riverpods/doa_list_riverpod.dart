import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/api/doa_api.dart';
import 'package:quran/models/doa_list_model.dart';

final doaListRiverpod =
    FutureProvider<List<Doa>>((ref) => ref.watch(getDoaApi).getDoaApi());
