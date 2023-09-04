import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:quran/models/doa_list_model.dart';

import 'package:quran/riverpods/doa_list_riverpod.dart';

import 'package:quran/screens/detail_doa_screen.dart';
import 'package:quran/widgets/doa_list.dart';

class DoaList extends ConsumerStatefulWidget {
  const DoaList({super.key});

  @override
  ConsumerState<DoaList> createState() => _DoaListState();
}

class _DoaListState extends ConsumerState<DoaList> {
  void _navDetailDoa(BuildContext context, Doa doaDetail) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoaDetail(doaDetail: doaDetail),
      ),
    );
  }

  Future<List<Doa>> _getDoa() async {
    final Uri url = Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api');
    final response = await http.get(url);

    final data = (jsonDecode(response.body) as List);

    final List<Doa> doaList = data.map((data) => Doa.fromJson(data)).toList();
    return doaList;
  }

  @override
  void initState() {
    super.initState();
    ref.read(doaListRiverpod);
    _getDoa();
  }

  @override
  Widget build(BuildContext context) {
    final doaDataApi = ref.watch(doaListRiverpod);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Doa',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4361ee),
      ),
      body: doaDataApi.when(
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final Doa doa = data[index];
              return DoaListWidget(data: doa, navDetail: _navDetailDoa);
            },
          );
        },
      ),
    );
  }
}
