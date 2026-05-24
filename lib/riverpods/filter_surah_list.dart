import 'package:flutter_riverpod/legacy.dart';
import 'package:quran/network/models/surah_model.dart';

class SearchUserController extends StateNotifier<List<Surah>> {
  SearchUserController() : super([]);

  onSearchUser(String query, List<Surah> data) {
    state = [];

    if (query.isNotEmpty) {
      final result = data
          .where(
            (element) =>
                element.namaLatin.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      state =
          result; // Pro-tip: You can assign 'result' directly instead of [...result]
    }
  }
}

final searchControllerProvider =
    StateNotifierProvider<SearchUserController, List<Surah>>((ref) {
  return SearchUserController();
});
