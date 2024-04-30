import 'package:easypark/pages/VistaPrincipal.dart';
import 'package:easypark/pages/mainNavigation.dart';
import 'package:easypark/pages/notifications.dart';
import 'package:easypark/pages/PreguntasFrecuentes.dart';
import 'package:easypark/pages/login.dart';
import 'package:easypark/pages/parked.dart';
import 'package:easypark/pages/sugerencias.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Alatsi'),
      home: MainNavigation(),
      routes: {
        '/mainNavigation': (context) =>
            MainNavigation(), // Asegúrate de que VistaPrincipal es el widget correcto para esta ruta
      },
    );
  }
}

