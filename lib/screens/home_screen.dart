import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/widgets/bottom_navbar.dart';
import 'package:quran/widgets/card_widget.dart';
import 'package:quran/widgets/gridview_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Al qur${"'"}an',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: Column(
        children: [
          const CardWidget(),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 18),
                child: const GridViewWidget()),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
