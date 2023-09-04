import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran/models/surah_model.dart';
import 'package:quran/riverpods/filter_surah_list.dart';

import 'package:search_page/search_page.dart';
import 'package:quran/riverpods/surah_riverpod.dart';
import 'package:quran/screens/detail_surah.dart';

class QuranListScreen extends ConsumerStatefulWidget {
  const QuranListScreen({super.key});

  @override
  ConsumerState<QuranListScreen> createState() => _QuranListScreenState();
}

class _QuranListScreenState extends ConsumerState<QuranListScreen> {
  void _navToDetail(Surah surah) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailSurahScreen(surah: surah),
    ));
  }

  @override
  void initState() {
    super.initState();
    ref.read(surahRiverpod);
  }

  @override
  Widget build(BuildContext context) {
    final surahDataApi = ref.watch(surahRiverpod);
    final searchController = ref.watch(searchControllerProvider);

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          title:
              const Text('Qur${"'"}an', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF4361ee),
          actions: [
            InkWell(
              onTap: () => surahDataApi.whenData((value) => showSearch(
                  context: context,
                  delegate: SearchPage(
                      failure: const Center(
                        child: Text('Not Found :('),
                      ),
                      builder: (data) {
                        return ListTile(
                          onTap: () {
                            _navToDetail(data);
                          },
                          leading: Container(
                              width: 50,
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset('assets/image/nomor.png'),
                                  Text(data.nomor.toString()),
                                ],
                              )),
                          title: Text(
                            data.namaLatin,
                            style: Theme.of(context).textTheme.titleMedium!,
                          ),
                          subtitle: Text(
                              '${data.tempatTurun} - ${data.jumlahAyat} Ayat'),
                          trailing: Text(
                            data.nama,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      filter: (data) => [data.namaLatin],
                      items: value))),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.search,
                  size: 26,
                ),
              ),
            )
          ],
        ),
        body: surahDataApi.when(
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (data) {
            List<Surah> dataList = data;

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchController.isNotEmpty
                          ? searchController.length
                          : dataList.length,
                      itemBuilder: (context, index) {
                        final Surah surah = searchController.isNotEmpty
                            ? searchController[index]
                            : dataList[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                          ),
                          child: ListTile(
                            onTap: () {
                              _navToDetail(surah);
                            },
                            leading: Container(
                                width: 50,
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset('assets/image/nomor_logo.png'),
                                    Text(surah.nomor.toString()),
                                  ],
                                )),
                            title: Text(
                              surah.namaLatin,
                              style: Theme.of(context).textTheme.titleMedium!,
                            ),
                            subtitle: Text(
                                '${surah.tempatTurun} - ${surah.jumlahAyat} Ayat'),
                            trailing: Text(
                              surah.nama,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
