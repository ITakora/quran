import 'package:flutter_riverpod/flutter_riverpod.dart';
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

      state = [...result];
    }
  }
}

final searchControllerProvider =
    StateNotifierProvider<SearchUserController, List>((ref) {
  return SearchUserController();
});
