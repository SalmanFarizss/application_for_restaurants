import 'package:application_for_restaurants/features/auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application for Restaurants',
      home:SplashScreen(),
      theme:ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
      ),
    );
  }
}
