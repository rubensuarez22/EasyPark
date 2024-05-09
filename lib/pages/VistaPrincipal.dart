import 'package:flutter/material.dart';
import 'package:easypark/pages/parked.dart'; // Ensure this file contains a Parked widget
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:easypark/models/location_data.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

//import 'package:geolocator/geolocator.dart';

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
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  // Función para manejar la selección del destino
void handleDestinationSelection(String? destinationName) async {
  requestLocationPermission();
  if (destinationName != null) {
    LocationData? selectedLocation = destinations.firstWhere(
      (location) => location.name == destinationName,
      orElse: () {
        return LocationData(
          id: 'default',
          name: 'Default Location',
          coordinates: LatLng(0.0, 0.0),
          type: LocationType.destination,
        );
      },
    );

    if (selectedLocation != null) {
      LocationData? nearestParking =
          findNearestParking(selectedLocation.coordinates);

      if (nearestParking != null) {
        setState(() {
          gMapMarkers = {};
          gMapMarkers[MarkerId(selectedLocation.id)] = Marker(
            markerId: MarkerId(selectedLocation.id),
            position: selectedLocation.coordinates,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: selectedLocation.name),
          );

          _addNearestParkingMarker(nearestParking);

          // Llama a la función para obtener la ruta
         
          _getRoute(nearestParking.coordinates);
        });
      }
    }
  }
}



  //FUNCIONES PARA HACER LA RUTA DE LA UBICACION AL ESTACIONAMIENTO
  //Funcion para solicitar permisos de la ubicacion del usuario

  //Variables
  //PolylinePoints polylinePoints = PolylinePoints();
  //List<LatLng> polylineCoordinates = [];
  //Map<PolylineId, Polyline> polylines = {};

  Future<void> requestLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      // Permiso concedido, puedes realizar acciones relacionadas con la ubicación
      print("permiso");
    } else {
      // Permiso denegado, muestra un mensaje o toma otra acción según sea necesario
      print('Permiso de ubicación denegado.');
    }
  }


  //Obtener la ubicacion actual
  Future<Position?> getCurrentLocation() async {
  try {
    // Solicitar permisos de ubicación si no están concedidos
    LocationPermission permission = await Geolocator.requestPermission();
   


    if (permission == LocationPermission.denied) {
      // Handle case where permission is denied
      print("No aceptado");
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  } catch (e) {
    print("Error obteniendo ubicación: $e");
    return null;
  }
}


//Utilizar funcion para obtener la ubicacion actual
/*
Future<void> _obtenerUbicacion() async {
  Position? position = await getCurrentLocation();
  if (position != null) {
    print("Ubicación actual: ${position.latitude}, ${position.longitude}");
    // Aquí puedes usar la ubicación obtenida según tus necesidades
  } else {
    print("No se pudo obtener la ubicación actual");
    // Manejar el caso en el que no se pueda obtener la ubicación
  }
}
*/
//Obtener la ruta
void _getRoute(LatLng destination) async {
  LatLng coordenadasExample = LatLng(19.050183, -98.284414);
  Position? currentPosition = await getCurrentLocation();
  if (currentPosition != null) {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyC511vzkC1QCs2wVGdoEjadSBXaSfp7uGw', // Tu clave API de Google Maps
      //PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(coordenadasExample.latitude, coordenadasExample.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = [];
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        PolylineId id = PolylineId('route');
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blue,
          points: polylineCoordinates,
          width: 3,
        );
        polylines[id] = polyline; // Agregar la polyline al mapa
      });
    }
  } else {
    // Manejar el caso en el que no se pudo obtener la ubicación actual
    print("No se pudo obtener la ubicación actual para calcular la ruta");
  }
}











  // Función para añadir marcador del estacionamiento más cercano
  void _addNearestParkingMarker(LocationData nearestParking) async {
    // Obtiene el documento del estacionamiento más cercano desde Firestore
    updateAvailableSpots();
  final parkingSnapshot = await FirebaseFirestore.instance.collection("ParkingLots").doc(selectedDestination).get();
  
  // Obtiene el número de lugares disponibles del documento
  int? availableSpots = parkingSnapshot.data()?["Lugares Disponibles"];
  
  // Crea el texto para mostrar en el marcador
  String spotsText = availableSpots != null ? 'Lugares disponibles: $availableSpots' : 'Lugares disponibles: No disponible';

  // Crea el marcador con la información actualizada
  Marker nearestParkingMarker = Marker(
    markerId: MarkerId('nearestParking'),
    position: nearestParking.coordinates,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    infoWindow: InfoWindow(
      title: 'Estacionamiento más cercano',
      snippet: spotsText,
    ),
  );

    // Añadir marcador del estacionamiento más cercano al mapa
    gMapMarkers[MarkerId('nearestParking')] = nearestParkingMarker;
  }

  void navigateToParked() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Parked(unlockFunction: unlockFirstOccupiedSpot,)), // Assuming Parked() is your target widget
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
      if(parking.availableSpots != null && parking.availableSpots! > 0){
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
                markers: Set<Marker>.of(gMapMarkers.values), // Asegúrate de usar el mapa actualizado de marcadores aquí
                polylines: Set<Polyline>.of(polylines.values)
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
            onPressed: () {
              
              updateFirstAvailableSpot();
              navigateToParked();
              

            },
            child: Text('Llegué'),
            
          ),
        ],
      ),
    );
  }

  Future<void> updateFirstAvailableSpot() async 
  {
  try {
    // Obtiene el estacionamiento seleccionado
    final parkingSnapshot = await FirebaseFirestore.instance.collection("ParkingLots").doc(selectedDestination).get();

    // Obtiene el array de disponibilidad del estacionamiento
    List<bool> availabilityArray = parkingSnapshot.data()?["Disponible"].cast<bool>();

    // Itera sobre el array de disponibilidad
    int availableSpotIndex = availabilityArray.indexOf(true);
    if (availableSpotIndex != -1) {
      // Actualiza la disponibilidad del cajón
      availabilityArray[availableSpotIndex] = false;

      // Actualiza el documento en Firestore
      await FirebaseFirestore.instance.collection("ParkingLots").doc(selectedDestination).update({
        "Disponible": availabilityArray,
      });

      print("Disponibilidad del cajón actualizada correctamente.");
      updateAvailableSpots();
    } else {
      print("No se encontraron cajones disponibles en este estacionamiento.");
    }
  } catch (e) {
    print("Error al actualizar la disponibilidad del cajón: $e");
  }
  }

  Future<void> unlockFirstOccupiedSpot() async {
  try {
    // Obtiene el estacionamiento seleccionado
    final parkingSnapshot = await FirebaseFirestore.instance.collection("ParkingLots").doc(selectedDestination).get();

    // Obtiene el array de disponibilidad del estacionamiento
    List<bool> availabilityArray = parkingSnapshot.data()?["Disponible"].cast<bool>();

    // Itera sobre el array de disponibilidad
    int occupiedSpotIndex = availabilityArray.indexOf(false);
    if (occupiedSpotIndex != -1) {
      // Desbloquea la disponibilidad del cajón
      availabilityArray[occupiedSpotIndex] = true;

      // Actualiza el documento en Firestore
      await FirebaseFirestore.instance.collection("ParkingLots").doc(selectedDestination).update({
        "Disponible": availabilityArray,
      });

      print("Desbloqueo del cajón exitoso.");
      updateAvailableSpots();
    } else {
      print("No se encontraron cajones ocupados en este estacionamiento.");
    }
  } catch (e) {
    print("Error al desbloquear el cajón: $e");
  }
  }

  void updateAvailableSpots() async {
  // Realiza una consulta a Firestore para obtener el documento del estacionamiento
  final parkingSpotSnapshot = await FirebaseFirestore.instance.collection("ParkingLots").doc(selectedDestination).get();
  
  // Obtiene el array de disponibilidad del estacionamiento desde Firestore
  List<bool> availabilityArray = List<bool>.from(parkingSpotSnapshot.data()?["Disponible"] ?? []);
  
  // Cuenta el número de lugares disponibles (True) en el array
  int availableSpots = availabilityArray.where((element) => element).length;

  // Actualiza el campo "available_spots" en Firestore con el nuevo valor
  await FirebaseFirestore.instance.collection("ParkingLots").doc(selectedDestination).update({
    "Lugares Disponibles": availableSpots,
  });

  print("Lugares disponibles actualizados correctamente: $availableSpots");
}

}

