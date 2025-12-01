import 'dart:convert';

class VhicleAddRequest {
  final String name;
  final int seats;
  final String transmission;
  final String fuelType;
  final String description;
  final List<String> features;

  VhicleAddRequest({
    required this.name,
    required this.seats,
    required this.transmission,
    required this.fuelType,
    required this.description,
    required this.features,
  });

  Map<String, String> toFields() {
    return {
      "name": name,
      "seats": seats.toString(),
      "transmission": transmission.toLowerCase(),
      "fuel_type": fuelType.toLowerCase(),
      "description": description,
      "features": jsonEncode(features),
    };
  }
}
