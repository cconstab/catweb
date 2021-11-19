import 'dart:html';
import 'package:flutter/material.dart';
import 'package:catweb/screens/public_radio_screen.dart';

void getParams() {
  var uri = Uri.dataFromString(window.location.href);
  Map<String, String> params = uri.queryParameters;
  var origin = params['origin'];
  var destiny = params['destiny'];
  print(origin);
  print(destiny);
}

void main() {
  getParams();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PublicRadioScreen(),
    );
  }
}
