import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/enter_number_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'otp Verification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      home: EnterMobileNumberScreen(),
    );
  }
}
