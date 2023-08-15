import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/models/detail_surah_model.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/riverpods/detail_surah_riverpod.dart';

class DetailSurahScreen extends ConsumerStatefulWidget {
  const DetailSurahScreen({super.key, required this.surah});

  final Surah surah;

  @override
  ConsumerState<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends ConsumerState<DetailSurahScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(detailSurahRiverpod(widget.surah.nomor));
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(detailSurahRiverpod(widget.surah.nomor));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Text(widget.surah.namaLatin),
        ),
        body: detail.when(
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                DetailSurah detailList = data[index];

                return ListTile(
                  contentPadding: const EdgeInsets.only(
                      top: 18, left: 18, right: 18, bottom: 10),
                  title: Card(
                    elevation: 5,
                    color: const Color(0xFFcbe4be),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/image/nomor_logo.png',
                                width: 50,
                              ),
                              Text(
                                detailList.nomorAyat.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Text(
                              detailList.teksArab,
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(detailList.teksLatin),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(detailList.teksIndonesia)
                      ]),
                );
              },
            );
          },
        ));
  }
}
