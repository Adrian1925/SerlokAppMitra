import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/service/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<SignupSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authService.signup(event.request);
        emit(AuthupSuccess(result));
      } catch (e) {
        print("Error: $e");
        emit(AuthupFailure(e.toString()));
      }
    });
    on<SigninSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authService.signin(event.request);
        emit(AuthinSuccess(result));
      } catch (e) {
        print("Error: $e");
        emit(AuthinFailure(e.toString()));
      }
    });
  }
}
