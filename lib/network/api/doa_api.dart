import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/network/models/doa_list_model.dart';
import 'package:http/http.dart' as http;

class DoaApi {
  Future<List<Doa>> getDoaApi() async {
    final Uri url = Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api');
    final response = await http.get(url);

    final data = (jsonDecode(response.body) as List);

    final List<Doa> doaList = data.map((data) => Doa.fromJson(data)).toList();
    return doaList;
  }
}

final getDoaApi = Provider<DoaApi>((ref) => DoaApi());
