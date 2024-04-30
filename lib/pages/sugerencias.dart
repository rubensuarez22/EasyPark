import 'package:flutter/material.dart';

class SugerenciasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sugerencias',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'En este espacio se pueden\nescribir sugerencias respecto a\nlos estacionamientos de la\nuniversidad o la aplicación',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 0.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange), // Color del contorno
              ),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Escribe tu sugerencia aquí',
                  border: InputBorder.none, // Oculta el borde del TextField
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar la sugerencia
              },
              child: Text(
                'Enviar',
                style: TextStyle(color: Colors.black), // Color del texto negro
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
