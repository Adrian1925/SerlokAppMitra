import 'dart:io';

import '../../../data/model/vhicle_add_model.dart';

abstract class VehicleEvent {}

class AddVehicleEvent extends VehicleEvent {
  final VhicleAddRequest data;
  final File fotoUtama;
  final File? fotoStnk;
  final File? fotoPajak;

  AddVehicleEvent({
    required this.data,
    required this.fotoUtama,
    this.fotoStnk,
    this.fotoPajak,
  });
}

class LoadVehicleList extends VehicleEvent {}


