import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
        // Cek data
        // TODO: Hapus pengecekan data ini nanti
        print('Mengirim data:');
        print('Data Selfie: ${state.selfiePhoto?.path}');
        print('Data KTP: ${state.identityPhoto?.path}');
        print('Data Alamat: ${state.address}');

        // Contoh simulasi submit data
        await Future.delayed(const Duration(seconds: 3));
        emit(state.copyWith(isSubmitting: false, isSuccess: true));

        // Reset data agar data tidk menumpuk
        emit(UpgradeAccountState.initial());

        // TODO: Hapus pengecekan data ini nanti
        print('Data terhapus:');
        print('Data Selfie: ${state.selfiePhoto?.path}');
        print('Data KTP: ${state.identityPhoto?.path}');
        print('Data Alamat: ${state.address}');
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isSuccess: false));
      }
    });
  }
}
