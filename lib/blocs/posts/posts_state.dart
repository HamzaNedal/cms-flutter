part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadingMoreState extends PostsState {}

class PostsLoadedState extends PostsState {
  // List<GetPosts> posts;
  List<Data> data;
  Meta meta;
  // GetPosts mergepost;
  // Function getAllPosts;

  // List<GetPosts> allPosts;
  // PostsLoadedState({this.posts, this.mergepost});
  PostsLoadedState({this.data, this.meta});
}

class PostsErrorState extends PostsState {
  String message;
  PostsErrorState({this.message});
}

class PostsCommentsLoadingState extends PostsState {}

class PostsCommentsLoadedState extends PostsState {
  GetPostCommets comments;
  PostsCommentsLoadedState({this.comments});
}
