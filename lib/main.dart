import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/splash_screen.dart';
import 'views/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloom',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF6E0F2D,
          <int, Color>{
            50: Color(0xFFFFE5E8),
            100: Color(0xFFFFB8C1),
            200: Color(0xFFFF8A98),
            300: Color(0xFFFF5C70),
            400: Color(0xFFFF2E48),
            500: Color(0xFF6E0F2D),
            600: Color(0xFFE00920),
            700: Color(0xFFC3071C),
            800: Color(0xFFA00617),
            900: Color(0xFF7E0412),
          },
        ),
      ),
      home: SplashScreen(),
    );
  }
}
