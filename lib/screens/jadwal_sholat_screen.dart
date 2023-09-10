import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';

import 'package:quran/riverpods/jadwal_sholat_riverpod.dart';
import 'package:quran/widgets/jadwal_sholat_list.dart';

class JadwalScreen extends ConsumerStatefulWidget {
  const JadwalScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends ConsumerState<JadwalScreen> {
  String userPlace = '';
  Position? position;
  bool isLoading = false;
  bool isMocked = false;

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    // Test if location services are enabled.
    await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    setState(() {
      isLoading = true;
    });
    final getPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (getPosition.isMocked == true) {
      isMocked = true;
    }

    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          getPosition.latitude, getPosition.longitude);
      Placemark place = placemark[0];
      setState(() {
        position = getPosition;
        userPlace = '${place.subAdministrativeArea}';
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });

    return getPosition;
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(jadwalSholatRiverpod(userPlace));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
      ),
      body: isMocked == true
          ? AlertDialog(
              title: const Text('Oops.. Something Wrong'),
              content: const Text(
                'Please disabele Fake GPS',
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            )
          : userPlace.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 600,
                    child: Card(
                      color: const Color(0xFFcbe4be),
                      elevation: 8,
                      child: Column(children: [
                        IconButton(
                            onPressed: _determinePosition,
                            icon: const Icon(
                              Icons.pin_drop_rounded,
                              size: 35,
                            )),
                        isLoading == true
                            ? const CircularProgressIndicator()
                            : Text(
                                userPlace,
                                style: const TextStyle(fontSize: 19),
                              ),
                        const SizedBox(
                          height: 18,
                        ),
                        data.when(
                          error: (error, stackTrace) => const Center(
                            child: Text('No data'),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          data: (data) {
                            return JadwalList(data: data);
                          },
                        )
                      ]),
                    ),
                  ),
                ),
    );
  }
}
