import 'package:easypark/pages/notifications.dart';
import 'package:easypark/pages/PreguntasFrecuentes.dart';
import 'package:easypark/pages/login.dart';
import 'package:easypark/pages/parked.dart';
import 'package:easypark/pages/sugerencias.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Alatsi'),
      home: Parked(),
    );
  }
}

