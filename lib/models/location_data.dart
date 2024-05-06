import 'package:google_maps_flutter/google_maps_flutter.dart';
// Asegúrate de usar el path correcto

// Enumeración para diferenciar tipos de ubicación
enum LocationType { destination, parking }

// Modelo de datos para representar una ubicación
class LocationData {
  final String id;
  final String name;
  final LatLng coordinates;
  final LocationType type;

  LocationData(
      {required this.id,
      required this.name,
      required this.coordinates,
      required this.type});
}

// Lista de destinos
final List<LocationData> destinations = [
  LocationData(
      id: "1",
      name: "Ingenierías",
      coordinates: LatLng(19.054045953267238, -98.28195441617939),
      type: LocationType.destination),
  LocationData(
      id: "2",
      name: "Humanidades",
      coordinates: LatLng(19.05293950991105, -98.28061464345627),
      type: LocationType.destination),
  LocationData(
      id: "3",
      name: "Ciencias Sociales",
      coordinates: LatLng(19.052545779286124, -98.28363437842752),
      type: LocationType.destination),

  LocationData(
      id: "4",
      name: "Centro Estudiantil",
      coordinates: LatLng(19.05384821803371, -98.2839067763243),
      type: LocationType.destination),

  LocationData(
      id: "5",
      name: "Ciencias de la salud",
      coordinates: LatLng(19.053706911739873, -98.28569643977258),
      type: LocationType.destination),

  LocationData(
      id: "6",
      name: "Colegio Cain Murray",
      coordinates: LatLng(19.054637782184372, -98.28387055584606),
      type: LocationType.destination),

  LocationData(
      id: "7",
      name: "Templo del dolor",
      coordinates: LatLng(19.054879858573717, -98.28543329128318),
      type: LocationType.destination),

  // Más destinos...
];

final List<LocationData> parkingSpots = [
  LocationData(
      id: "1",
      name: "Estacionamiento 1",
      coordinates: LatLng(19.055490356082654, -98.28252611343008),
      type: LocationType.parking),
  LocationData(
      id: "2",
      name: "Estacionamiento 2",
      coordinates: LatLng(19.054964368672263, -98.28149381520501),
      type: LocationType.parking),

  LocationData(
      id: "3",
      name: "Estacionamiento 3",
      coordinates: LatLng(19.053824545061378, -98.28055955953495),
      type: LocationType.parking),

  LocationData(
      id: "4",
      name: "Estacionamiento 4",
      coordinates: LatLng(19.051962586515412, -98.28194588045986),
      type: LocationType.parking),

  LocationData(
      id: "5",
      name: "Estacionamiento 5",
      coordinates: LatLng(19.052761198488138, -98.28443159502199),
      type: LocationType.parking),

  LocationData(
      id: "6",
      name: "Estacionamiento 6",
      coordinates: LatLng(19.052563189675755, -98.28532614439902),
      type: LocationType.parking),

  LocationData(
      id: "7",
      name: "Estacionamiento 7",
      coordinates: LatLng(19.053928249863265, -98.28682204879013),
      type: LocationType.parking),

  LocationData(
      id: "8",
      name: "Estacionamiento 8",
      coordinates: LatLng(19.055250143463734, -98.2838512983873),
      type: LocationType.parking),
  // Más estacionamientos...
];
