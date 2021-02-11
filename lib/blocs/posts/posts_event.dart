part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends PostsEvent {}

class FetchPostsWhenRefeshEvent extends PostsEvent {}

class FetchPostsBackEvent extends PostsEvent {}

class FetchMorePostsEvent extends PostsEvent {
  int toPage;
  FetchMorePostsEvent({this.toPage});
}

class AddPostEevet extends PostsEvent {}

class UpdatePostEevet extends PostsEvent {}

class DeletePostEevet extends PostsEvent {}

class FetchPostCommentsEvent extends PostsEvent {
  String slug;
  int index;
  FetchPostCommentsEvent({this.slug, this.index});
}
