import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cms/data/model/get_post.dart';
import 'package:cms/data/model/get_post_comments.dart';
import 'package:cms/data/repository/post_repo.dart';
import 'package:cms/data/repository/comment_repo.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final Posts post_repo;
  final PostCommentsRepo postComments_repo;
  List<Data> postsData = [];
  Meta meta = Meta();
  int initialScrollIndex = 0;
  bool isRefreshingPage = false;
  bool isLoadingMorePosts = false;
  // GetPosts mergepost = GetPosts();
  PostsBloc(this.post_repo, this.postComments_repo) : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (state is PostsInitial || event is FetchPostsWhenRefeshEvent) {
      initialScrollIndex = 0;
      yield PostsLoadingState();
      final data = await post_repo.getPosts(1);
      postsData.clear();
      postsData.addAll(data[0]['data']);
      meta = data[0]['meta'];
      try {
        if (!data[0]['errors']) {
          yield PostsLoadedState(data: postsData, meta: meta);
        }
      } catch (e) {
        yield PostsErrorState(message: e.toString());
      }
    } else if (event is FetchMorePostsEvent) {
      yield PostsLoadingMoreState();
      final data = await post_repo.getPosts(event.toPage);
      yield PostsLoadingState();
      try {
        if (!data[0]['errors']) {
          postsData.addAll(data[0]['data']);
          meta = data[0]['meta'];
          yield PostsLoadedState(data: postsData, meta: meta);
        }
      } catch (e) {
        yield PostsErrorState(message: e.toString());
      }
    } else if (event is FetchPostCommentsEvent) {
      initialScrollIndex = event.index;
      yield PostsCommentsLoadingState();
      final data = await postComments_repo.getComments(event.slug);
      try {
        if (!data[0]['errors']) {
          yield PostsCommentsLoadedState(comments: data[0]['data']);
        }
      } catch (e) {
        yield PostsErrorState(message: e.toString());
      }
    } else if (event is FetchPostsBackEvent) {
      yield PostsLoadedState(data: postsData, meta: meta);
    }
  }
}
