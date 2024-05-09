import 'package:easypark/pages/VistaPrincipal.dart';
import 'package:easypark/pages/mainNavigation.dart';
import 'package:easypark/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:easypark/providers/user_id_provider.dart'; // Importa la clase UserIdProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // Envuelve MaterialApp con ChangeNotifierProvider
      create: (context) => UserIdProvider(), // Crea una instancia de UserIdProvider
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Alatsi'),
        home: const login(),
        routes: {
          '/mainNavigation': (context) => const MainNavigation(),
        },
      ),
    );
  }
}

class UserIdProvider extends ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  void setUserId(String? userId) {
    _userId = userId;
    notifyListeners();
  }
}
