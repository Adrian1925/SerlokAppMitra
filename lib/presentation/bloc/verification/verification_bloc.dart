import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/service/profile_service.dart';
part 'verification_event.dart';
part 'verification_state.dart';

class UpgradeAccountBloc
    extends Bloc<UpgradeAccountEvent, UpgradeAccountState> {
  UpgradeAccountBloc() : super(UpgradeAccountState.initial()) {
    on<SaveSelfiePhoto>((event, emit) {
      emit(state.copyWith(selfiePhoto: event.imageFile));
    });

    on<SaveIdentityPhoto>((event, emit) {
      emit(state.copyWith(identityPhoto: event.imageFile));
    });

    on<ResetData>((event, emit) {
      final currentState = state;

      switch (event.scope) {
        case ResetScope.all:
          emit(UpgradeAccountState.initial());
          break;
        case ResetScope.selfieOnly:
          emit(currentState.copyWith(selfiePhoto: null));
          break;
        case ResetScope.identityOnly:
          emit(currentState.copyWith(identityPhoto: null));
          break;
      }
    });

    on<SubmitData>((event, emit) async {
      final updatedState = state.copyWith(address: event.address);

      if (!updatedState.isComplete) {
        emit(updatedState.copyWith(error: 'Data belum lengkap'));
        return;
      }

      emit(updatedState.copyWith(isSubmitting: true, error: null));

      try {
        final profileService = ProfileService();
        print("Mengupload selfie...");
        final selfieRes = await profileService.uploadSelfie(updatedState.selfiePhoto!);
        print("Selfie result: $selfieRes");
        print("Mengupload KTP...");
        final ktpRes = await profileService.uploadKtp(updatedState.identityPhoto!);
        print("KTP result: $ktpRes");
        print("Mengupdate alamat...");
        final addressRes = await profileService.uploadAddress(updatedState.address!);
        print("Address result: $addressRes");
        emit(updatedState.copyWith(isSubmitting: false, isSuccess: true));
        print("Sukses mengirim data verifikasi!");
        emit(UpgradeAccountState.initial());
      } catch (e) {
        print("ERROR submit: $e");
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          error: e.toString(),
        ));
      }
    });
  }
}
