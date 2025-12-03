import 'package:equatable/equatable.dart';
import '../../../data/model/vehicle_model.dart';

class VehicleState extends Equatable {
  final List<VehicleModel> vehicles;
  final bool isLoading;
  final bool isSuccess;
  final String message;

  const VehicleState({
    this.vehicles = const [],
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });

  VehicleState copyWith({
    List<VehicleModel>? vehicles,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return VehicleState(
      vehicles: vehicles ?? this.vehicles,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [vehicles, isLoading, isSuccess, message];
}


