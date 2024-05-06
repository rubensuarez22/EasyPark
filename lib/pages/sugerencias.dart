import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SugerenciasView extends StatefulWidget {
  @override
  _SugerenciasViewState createState() => _SugerenciasViewState();
}

class _SugerenciasViewState extends State<SugerenciasView> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _sendSuggestion() async {
    String suggestionText = _controller.text.trim();

    if (suggestionText.isEmpty) {
      _showMessage("Por favor, ingresa una sugerencia.");
      return;
    }

    try {
      await _firestore.collection('suggestions').add({
        'suggestion': suggestionText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _controller.clear();
      _showMessage("Sugerencia enviada con éxito.");
    } catch (e) {
      _showMessage("Error al enviar sugerencia: $e");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 40.0,
                  left: 18.0,
                  right:
                      20.0), // Apply padding only to the top and sides for the title
              child: Text(
                'Sugerencias',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                  bottom: 20.0), // Apply padding to text
              child: Text(
                'En este espacio se pueden escribir sugerencias respecto a los estacionamientos de la universidad o la aplicación',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20.0), // Horizontal margin for container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Escribe tu sugerencia aquí',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0), // Padding inside the TextField
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0), // Apply padding for the button
              child: ElevatedButton(
                onPressed: _sendSuggestion,
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
