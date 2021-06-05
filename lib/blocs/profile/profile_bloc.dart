import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cms/data/model/user_posts.dart';
import 'package:cms/data/repository/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserImp userPosts = UserImp();
  UserPosts posts = UserPosts();
  ProfileBloc() : super(ProfileInitialState());
  double changeToPostsFullScreen = 0.0;
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    var pref = await SharedPreferences.getInstance();
    if (event is GetUserInfo) {
      // print('ssss');
      var data = await userPosts.getUserPosts();
      // yield ProfileInitialState();
      posts = data[0]['data'];
      // print(data);
      yield ProfileIsReadyState(
          name: pref.get('name'),
          username: pref.get('username'),
          image: pref.get('image'),
          posts: posts);
    }
    // if (event is ChangeStyleEvent) {
    //   yield ChangeStyleEventState();
    //   changeToPostsFullScreen = event.heightPosts;
    //   yield ProfileIsReadyState(
    //     name: pref.get('name'),
    //     username: pref.get('username'),
    //     image: pref.get('image'),
    //     posts: posts,
    //   );

    //   // if (event.heightPosts > 0 && changeToPostsFullScreen == false) {}
    // }
    if (event is DeletePostEvent) {
      // ;
      // print(event.data);
      // print(posts.data.remove(event.data));
      posts.data.remove(event.data);
      var data = await userPosts.deleteUserPost(event.data.postId);
      yield DeletePostState();
      print(data);
      yield ProfileIsReadyState(
          name: pref.get('name'),
          username: pref.get('username'),
          image: pref.get('image'),
          posts: posts);
    }
    if (event is ChangeStatusOfPostEvent) {
      await userPosts.updateUserPostStatus(event.data.postId);
      int indexData = posts.data.indexWhere((element) {
        return element.postId == event.data.postId;
      });
      posts.data[indexData].status = event.status;
      yield ChangeStatusOfPostState(status: event.status);
      yield ProfileIsReadyState(
        name: pref.get('name'),
        username: pref.get('username'),
        image: pref.get('image'),
        posts: posts,
      );
    }
  }
}
