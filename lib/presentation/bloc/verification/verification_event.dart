part of 'verification_bloc.dart';

@immutable
sealed class UpgradeAccountEvent {
  const UpgradeAccountEvent();

  List<Object?> get data => [];
}

final class SaveSelfiePhoto extends UpgradeAccountEvent {
  final File imageFile;
  const SaveSelfiePhoto(this.imageFile);

  @override
  List<Object?> get data => [imageFile];
}

final class SaveIdentityPhoto extends UpgradeAccountEvent {
  final File imageFile;
  const SaveIdentityPhoto(this.imageFile);

  @override
  List<Object?> get data => [imageFile];
}

enum ResetScope { all, selfieOnly, identityOnly }

final class ResetData extends UpgradeAccountEvent {
  final ResetScope scope;
  const ResetData({this.scope = ResetScope.all});

  List<Object?> get props => [scope];
}

final class SubmitData extends UpgradeAccountEvent {
  final String address;
  const SubmitData(this.address);

  @override
  List<Object?> get data => [address];
}
