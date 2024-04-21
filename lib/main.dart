// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_ranker/pages/navigation_page.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes : {
        '/' : (context) => NavigationPage(),
      }
    );
  }
}
