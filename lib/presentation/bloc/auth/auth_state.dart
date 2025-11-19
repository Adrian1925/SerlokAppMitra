import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthupSuccess extends AuthState {
  final Map<String, dynamic> data;
  AuthupSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthinFailure extends AuthState {
  final String error;
  AuthinFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthinSuccess extends AuthState {
  final Map<String, dynamic> data;
  AuthinSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthupFailure extends AuthState {
  final String error;
  AuthupFailure(this.error);

  @override
  List<Object?> get props => [error];
}
