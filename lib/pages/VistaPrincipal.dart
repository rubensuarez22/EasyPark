import 'package:flutter/material.dart';


class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          // Encabezado con imagen y botón
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Imagen del lado izquierdo
                Image.asset('assets/images/udlap_logo.png', width: 75, height: 75),
                // Botón del lado derecho
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                  child: Text('Llegué'),
                ),
              ],
            ),
          ),
          // Lista desplegable 1
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Escoge tu destino'),
              onChanged: (String? newValue) {
                // Acción al seleccionar un elemento de la lista desplegable
              },
              items: <String>['Ingenierías', 'Humanidades', 'Salud', 'Ciencias Sociales', 'Negocios', 'Gimnasio']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Lista desplegable 2
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Escoge tu tipo de vehículo'),
              onChanged: (String? newValue) {
                // Acción al seleccionar un elemento de la lista desplegable
              },
              items: <String>['Carro', 'Moto']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}