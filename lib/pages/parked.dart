import 'package:flutter/material.dart';

class Parked extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centra el título en la AppBar
        title: Text(
          'Parked',
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
       body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              margin: EdgeInsets.only(bottom: 50), // Espacio entre la imagen y el botón
              child: Image.asset('assets/images/ParkedImageNBG.png', // Ruta de la imagen
              height: 300, // Altura de la imagen 
              ),
              ),
               Container(
              margin: EdgeInsets.only(bottom: 100),
              height: 50, // Altura de la imagen 
              child: ElevatedButton(
                    onPressed: () {
                    // Acción a realizar cuando se presiona el botón
                    print('Unlock Parking Lot');
                    },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 165, 0, 0.7), // Color naranja con opacidad
                    ),
                    child: Text(
                              'Unlock', 
                              style: TextStyle(
                              color: Colors.white, // Color del texto del botón
                              fontSize: 18, // Tamaño de fuente del texto del botón
                              ),
                            ),
              ), 
              ),
              
            ], // Children
          ), 
        ), 
    );
  }
}


