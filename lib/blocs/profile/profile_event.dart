part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends ProfileEvent {}

class ChangeStyleEvent extends ProfileEvent {
  final double heightPosts;
  ChangeStyleEvent({this.heightPosts});
}

class ChangeStatusOfPostEvent extends ProfileEvent {
  final int status;
  final Data data;
  ChangeStatusOfPostEvent({this.status, this.data});
}

class DeletePostEvent extends ProfileEvent {
  final data;
  DeletePostEvent({this.data});
}
