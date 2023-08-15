import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Assalamualikum',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Achmad Rizky ',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
              Lottie.asset('assets/lottie/animasi_quran.json',
                  width: 180, height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
