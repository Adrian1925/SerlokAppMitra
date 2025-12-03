import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/service/vhicle_service.dart';
import 'add_vehicle_event.dart';
import 'add_vehicle_state.dart';
class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VhicleService service;

  VehicleBloc(this.service) : super(const VehicleState()) {
    
    on<LoadVehicleList>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final list = await service.getVehicleList();
        emit(state.copyWith(
          isLoading: false,
          vehicles: list,
          message: "",
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          vehicles: [],
          message: e.toString(),
        ));
      }
    });

    on<AddVehicleEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final success = await service.addVhicle(
          data: event.data,
          fotoUtama: event.fotoUtama,
          fotoStnk: event.fotoStnk,
          fotoPajak: event.fotoPajak,
        );
        print("==============================");
        print("AddVehicleEvent: $success");
        emit(state.copyWith(
          isLoading: false,
          isSuccess: success,
          message: success ? "Berhasil menambah kendaraan" : "Gagal menambah kendaraan",
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          message: e.toString(),
        ));
      }
    });
  }
}
