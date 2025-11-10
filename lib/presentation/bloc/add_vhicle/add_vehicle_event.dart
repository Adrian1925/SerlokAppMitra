abstract class VehicleEvent {}

class VehicleUpdate extends VehicleEvent {
  final Function() update;
  VehicleUpdate(this.update);
}

class VehicleSubmit extends VehicleEvent {}
