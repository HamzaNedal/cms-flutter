part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class LoadingProfilePostsState extends ProfileState {}

class ProfileIsReadyState extends ProfileState {
  final String name;
  final String username;
  final String image;
  final UserPosts posts;
  ProfileIsReadyState({this.name, this.username, this.image, this.posts});
}

class ChangeStyleEventState extends ProfileState {}

class DeletePostState extends ProfileState {}

class ChangeStatusOfPostState extends ProfileState {
  final int status;
  ChangeStatusOfPostState({this.status});
}
