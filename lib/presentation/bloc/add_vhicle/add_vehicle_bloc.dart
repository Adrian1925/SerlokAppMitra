import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/vehicle_model.dart';
import 'add_vehicle_event.dart';
import 'add_vehicle_state.dart';


class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleState(data: VehicleModel())) {
    on<VehicleUpdate>((event, emit) {
      event.update();
      emit(state.copyWith(data: state.data));
    });

    on<VehicleSubmit>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(Duration(seconds: 1));

      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
