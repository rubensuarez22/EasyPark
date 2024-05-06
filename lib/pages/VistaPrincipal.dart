import 'package:flutter/material.dart';
import 'package:easypark/pages/parked.dart'; // Ensure this file contains a Parked widget
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:easypark/models/location_data.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedDestination;
  String? selectedVehicleType;
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> gMapMarkers = {};
  Marker? destinationMarker;

  // Función para manejar la selección del destino
  void handleDestinationSelection(String? destinationName) {
    if (destinationName != null) {
      // Buscar las coordenadas del destino seleccionado
      LocationData? selectedLocation = destinations.firstWhere(
        (location) => location.name == destinationName,
        orElse: () {
          // Handle the case where no matching location is found
          // You can return a default LocationData instance or take appropriate action
          return LocationData(
            id: 'default',
            name: 'Default Location',
            coordinates: LatLng(0.0, 0.0),
            type: LocationType.destination,
          );
        },
      );

      if (selectedLocation != null) {
        // Encontrar el estacionamiento más cercano al destino seleccionado
        LocationData? nearestParking =
            findNearestParking(selectedLocation.coordinates);

        if (nearestParking != null) {
          // Actualizar los marcadores en el mapa
          setState(() {
            // Limpiar todos los marcadores existentes
            gMapMarkers = {};

            // Añadir marcador del destino seleccionado
            gMapMarkers[MarkerId(selectedLocation.id)] = Marker(
              markerId: MarkerId(selectedLocation.id),
              position: selectedLocation.coordinates,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              infoWindow: InfoWindow(title: selectedLocation.name),
            );

            // Añadir marcador del estacionamiento más cercano
            _addNearestParkingMarker(nearestParking.coordinates);
          });
        }
      }
    }
  }

  // Función para añadir marcador del estacionamiento más cercano
  void _addNearestParkingMarker(LatLng parkingCoordinates) {
    Marker nearestParkingMarker = Marker(
      markerId: MarkerId('nearestParking'),
      position: parkingCoordinates,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: 'Estacionamiento más cercano'),
    );

    // Añadir marcador del estacionamiento más cercano al mapa
    gMapMarkers[MarkerId('nearestParking')] = nearestParkingMarker;
  }

  void navigateToParked() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Parked()), // Assuming Parked() is your target widget
    );
  }

  static const UDLAP = LatLng(19.054167112533342, -98.283821525037);
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: UDLAP,
    zoom: 16.0,
  );

  //Calculate distance

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  //Find nearestParking

  LocationData? findNearestParking(LatLng destination) {
    LocationData? nearestParking;
    double closestDistance = double.infinity;

    for (LocationData parking in parkingSpots) {
      double distance = calculateDistance(
        destination.latitude,
        destination.longitude,
        parking.coordinates.latitude,
        parking.coordinates.longitude,
      );
      if (distance < closestDistance) {
        closestDistance = distance;
        nearestParking = parking;
      }
    }

    return nearestParking;
  }

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
                markers: Set<Marker>.of(gMapMarkers
                    .values), // Asegúrate de usar el mapa actualizado de marcadores aquí
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
        handleDestinationSelection(newValue);
      },
      items: destinations.map((LocationData data) {
        return DropdownMenuItem<String>(
          value: data.name,
          child: Text(data.name),
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
