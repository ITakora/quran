import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quran/widgets/card_widget.dart';
import 'package:quran/widgets/gridview_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(5.0),
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
        mainAxisSize: MainAxisSize.max,
        children: [
          const CardWidget(),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 15),
                child: const GridViewWidget()),
          ),
        ],
      ),
    );
  }
}
