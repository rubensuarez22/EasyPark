import 'package:flutter/material.dart';
import 'package:easypark/pages/parked.dart'; // Ensure this file contains a Parked widget
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedDestination;
  String? selectedVehicleType;
  final Completer<GoogleMapController> _controller = Completer();

  void navigateToParked() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Parked()), // Assuming Parked() is your target widget
    );
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(19.054167112533342, -98.283821525037),
    zoom: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _containerTopBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _dropDownButtonDestination(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _dropDownButtonTypeOfVehicle(),
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> _dropDownButtonTypeOfVehicle() {
    return DropdownButton<String>(
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
    );
  }

  DropdownButton<String> _dropDownButtonDestination() {
    return DropdownButton<String>(
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
    );
  }

  Container _containerTopBar() {
    return Container(
      padding: EdgeInsets.only(top: 40.0, left: 18.0, right: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/udlap_logo.png', width: 75, height: 75),
          ElevatedButton(
            onPressed: navigateToParked,
            child: Text('Llegué'),
          ),
        ],
      ),
    );
  }
}
