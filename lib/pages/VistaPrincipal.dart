import 'package:flutter/material.dart';
import 'package:easypark/pages/parked.dart'; // Ensure this file contains a Parked widget

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedDestination;
  String? selectedVehicleType;

  void navigateToParked() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Parked()), // Assuming Parked() is your target widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40.0, left: 18.0, right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/udlap_logo.png',
                      width: 75, height: 75),
                  ElevatedButton(
                    onPressed: navigateToParked,
                    child: Text('Llegué'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: selectedDestination, // Bind the selected value
                isExpanded: true,
                hint: Text('Escoge tu destino'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDestination = newValue;
                  });
                },
                items: <String>[
                  'Ingenierías',
                  'Humanidades',
                  'Salud',
                  'Ciencias Sociales',
                  'Negocios',
                  'Gimnasio'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: selectedVehicleType, // Bind the selected value
                isExpanded: true,
                hint: Text('Escoge tu tipo de vehículo'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedVehicleType = newValue;
                  });
                },
                items: <String>['Carro', 'Moto'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
