import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/service/profile_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;

  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());

      try {
        final profile = await profileService.getProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
    on<UpdateOnlineStatus>((event, emit) async {
  final current = state;

  if (current is ProfileLoaded) {
    final previousProfile = current.profile;

    final updatedProfile = previousProfile.copyWith(
      state: event.isOnline ? "online" : "offline",
    );

    emit(ProfileLoaded(updatedProfile));

    try {
      final result = await profileService.changeState(
        event.isOnline ? "online" : "offline",
      );

      if (result["status"] != 200) {
        print("Gagal update status, rollback...");
        emit(ProfileLoaded(previousProfile));
      }

    } catch (e) {
      print("Error API: $e");

      emit(ProfileLoaded(previousProfile));
    }
  }
});

  }
}
