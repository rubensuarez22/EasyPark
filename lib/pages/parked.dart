import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:easypark/pages/VistaPrincipal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef UnlockFunction = Future<void> Function();

class Parked extends StatelessWidget {

  final UnlockFunction unlockFunction;
  
  Parked({required this.unlockFunction});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Parked',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: 50), // Espacio entre la imagen y el botón
              child: Image.asset(
                'assets/images/ParkedImageNBG.png', // Ruta de la imagen
                height: 300, // Altura de la imagen
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 100),
              height: 50, // Altura del botón
              child: ElevatedButton(
                onPressed: () async {
                  // Navigate back to the previous page
                  
                  await unlockFunction();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(
                      255, 165, 0, 0.7), // Color naranja con opacidad
                ),
                child: const Text(
                  'Unlock',
                  style: TextStyle(
                    color: Colors.white, // Color del texto del botón
                    fontSize: 18, // Tamaño de fuente del texto del botón
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
  
}
