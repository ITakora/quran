import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/doa_list_model.dart';

class DoaListWidget extends ConsumerWidget {
  const DoaListWidget({super.key, required this.data, required this.navDetail});

  final Doa data;
  final void Function(BuildContext context, Doa doaDetail) navDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
        //   itemCount: filterDoa.isNotEmpty ? filterDoa.length : data.l,
        //   itemBuilder: (context, index) {
        //     final Doa listDoa =
        //         filterDoa.isNotEmpty ? filterDoa[index] : data[index];
        InkWell(
      onTap: () {
        navDetail(context, data);
      },
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.only(top: 16, right: 10, left: 10, bottom: 10),
        color: const Color(0xFFcaf0f8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Row(
            children: [
              Text('${data.id}.'),
              const SizedBox(
                width: 15,
              ),
              Text(data.doa),
            ],
          ),
        ),
      ),
    );
    // child: TextField(
    //   onChanged: (value) {
    //     ref.read(searchfilterDoa.notifier).searchfilter(value, data);
    //   },
    //   style: const TextStyle(fontSize: 16),
    //   autocorrect: false,
    //   textCapitalization: TextCapitalization.words,
    //   decoration: InputDecoration(
    //     prefixIcon: const Icon(Icons.search),
    //     hintText: 'Search Doa...',
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //   ),
    // ),
  }
}
