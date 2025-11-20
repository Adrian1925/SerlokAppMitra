import 'package:equatable/equatable.dart';
import '../../../data/model/auth_singup_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends AuthEvent {
  final SignupRequest request;

  SignupSubmitted(this.request);

  @override
  List<Object?> get props => [request];
}

class SigninSubmitted extends AuthEvent {
  final SigninRequest request;

  SigninSubmitted(this.request);

  @override
  List<Object?> get props => [request];
}