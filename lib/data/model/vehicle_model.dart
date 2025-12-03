class VehicleModel {
  final int id;
  final String name;
  final int seats;
  final String transmission;
  final String fuelType;
  final String status;
  final String pictureUrl;

  VehicleModel({
    required this.id,
    required this.name,
    required this.seats,
    required this.transmission,
    required this.fuelType,
    required this.status,
    required this.pictureUrl,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      seats: json['seats'] is int
          ? json['seats']
          : int.parse(json['seats'].toString()),
      transmission: json['transmission'] ?? '',
      fuelType: json['fuel_type'] ?? '',
      status: json['status'] ?? '',
      pictureUrl: json['picture_url'] ?? '',
    );
  }
}
