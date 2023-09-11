import 'package:flutter/material.dart';
import 'package:quran/screens/doa_list_screens.dart';
import 'package:quran/screens/jadwal_sholat_screen.dart';
import 'package:quran/screens/surah_list_screen.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  void _navDoaList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const DoaList(),
    ));
  }

  void _navJadwalScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const JadwalScreen(),
    ));
  }

  void _navQuranList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const QuranListScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool isDekstop = MediaQuery.of(context).size.width >= 600;

    return GridView(
      gridDelegate: isDekstop
          ? const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 3 / 3)
          : const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 3 / 3),
      children: <Widget>[
        InkWell(
          onTap: () {
            _navQuranList(context);
          },
          child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFF4361ee),
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/quran_logo.png',
                    width: 100,
                  ),
                  Text(
                    'Qur${"'"}an',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ],
              )),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF4361ee),
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/hadist_logo.png',
                width: 100,
              ),
              Text(
                'Hadist',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            _navDoaList(context);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF4361ee),
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/doa_logo.png',
                  width: 100,
                ),
                Text(
                  'Doa',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF4361ee),
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: InkWell(
            onTap: () {
              _navJadwalScreen(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/jadwal_sholat.png',
                  width: 120,
                ),
                Text(
                  'Jadwal Sholat',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
