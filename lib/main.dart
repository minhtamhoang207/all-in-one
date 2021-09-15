import 'package:flutter/material.dart';
import 'package:search_cubit/screens/home.dart';
import 'package:search_cubit/screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (_) => HomePage(),
        "/search": (BuildContext context) => Search(),
      },
    );
  }
}
