import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDekstop = MediaQuery.of(context).size.width >= 600;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          color: const Color(0xFF4361ee),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Assalamualikum',
                      style: isDekstop
                          ? Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )
                          : Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Wr.Wb ',
                      style: isDekstop
                          ? Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )
                          : Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 19),
                    ),
                    isDekstop
                        ? SizedBox(
                            height: 10,
                          )
                        : const SizedBox(
                            height: 80,
                          ),
                  ],
                ),
              ),
              isDekstop
                  ? Lottie.asset('assets/lottie/animasi_quran.json',
                      width: 300, height: 300)
                  : Lottie.asset('assets/lottie/animasi_quran.json',
                      width: 170, height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
