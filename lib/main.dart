import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/notification.dart';
import 'package:timezone/data/latest.dart' as tz;

final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFF4361ee),
    surface: Colors.transparent);

final theme = ThemeData().copyWith(
    primaryColor: const Color(0xFF4361ee),
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.poppinsTextTheme());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qur${"'"}an',
      theme: theme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
