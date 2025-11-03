part of 'verification_bloc.dart';

@immutable
class UpgradeAccountState {
  final File? selfiePhoto;
  final File? identityPhoto;
  final String? address;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const UpgradeAccountState({
    this.selfiePhoto,
    this.identityPhoto,
    this.address,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  factory UpgradeAccountState.initial() => const UpgradeAccountState();

  bool get isComplete =>
      selfiePhoto != null &&
      identityPhoto != null &&
      address != null &&
      address!.isNotEmpty;

  UpgradeAccountState copyWith({
    File? selfiePhoto,
    File? identityPhoto,
    String? address,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return UpgradeAccountState(
      selfiePhoto: selfiePhoto ?? this.selfiePhoto,
      identityPhoto: identityPhoto ?? this.identityPhoto,
      address: address ?? this.address,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}
