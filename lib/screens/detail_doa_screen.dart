import 'package:flutter/material.dart';
import 'package:quran/models/doa_list_model.dart';

class DoaDetail extends StatelessWidget {
  const DoaDetail({super.key, required this.doaDetail});

  final Doa doaDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doaDetail.doa),
      ),
      body: ListView.builder(
        itemCount: doaDetail.id.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Card(
              elevation: 5,
              color: const Color(0xFFcbe4be),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  doaDetail.ayat,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 14,
                ),
                Text(
                  doaDetail.latin,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(' ${doaDetail.artinya}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
