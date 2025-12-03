abstract class ProfileEvent {}

class FetchProfile extends ProfileEvent {}

class UpdateOnlineStatus extends ProfileEvent {
  final bool isOnline;
  UpdateOnlineStatus(this.isOnline);
}