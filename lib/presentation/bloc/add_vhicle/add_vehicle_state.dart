import '../../../../data/model/vehicle_model.dart';

class VehicleState {
  final VehicleModel data;
  final bool isLoading;
  final bool isSuccess;

  VehicleState({
    required this.data,
    this.isLoading = false,
    this.isSuccess = false,
  });

  VehicleState copyWith({
    VehicleModel? data,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return VehicleState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}


