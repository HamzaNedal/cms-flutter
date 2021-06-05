import 'dart:convert';

import 'package:cms/constants.dart';
import 'package:cms/data/model/get_post.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Posts {
  Future<List> getPosts(int page);
  addPost();
  updatePost();
  deletePost();
}

class PostsImp extends Posts {
  @override
  Future<List> getPosts(int page) async {
    List responseToBloc = [];
    try {
      final pref = await SharedPreferences.getInstance();
      if (pref.getString('access_token') == null) {
        responseToBloc.add({'errors': true, 'data': 'LoginScreen'});
        return responseToBloc;
      }
      var accessToken = pref.getString('access_token');
      Map<String, String> headers = {
        'Authorization': 'Bearer ' + accessToken,
        'X-Requested-With': 'XMLHttpRequest',
        'Accept': 'application/json',
      };
      final response =
          await get('$kHost/api/v1/get-posts?page=${page}', headers: headers);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        responseToBloc.add({
          'errors': false,
          'data': GetPosts.fromJson(data).data,
          'meta': GetPosts.fromJson(data).meta
        });
        return responseToBloc;
      } else {
        responseToBloc.add({'errors': true, 'data': 'No posts founded'});
        return responseToBloc;
      }
    } catch (e) {
      responseToBloc.add({'errors': true, 'data': e.toString()});
      return responseToBloc;
    }
  }

  @override
  addPost() {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  deletePost() {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  updatePost() {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
