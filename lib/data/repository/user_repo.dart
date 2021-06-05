import 'dart:convert';

import 'package:cms/constants.dart';
import 'package:cms/data/model/user_posts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class User {
  Future<List> getUserPosts();
  addUserPost();
  updateUserPost();
  updateUserPostStatus(int id);
  deleteUserPost(int slug);
}

class UserImp extends User {
  @override
  Future<List> getUserPosts() async {
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
      final response = await get('$kHost/api/v1/my-posts', headers: headers);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        responseToBloc.add({
          'errors': false,
          'data': UserPosts.fromJson(data),
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
  addUserPost() {
    // TODO: implement addUserPost
    throw UnimplementedError();
  }

  @override
  deleteUserPost(int id) async {
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
          await delete('$kHost/api/v1/my-posts/${id}', headers: headers);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        responseToBloc.add({
          'errors': false,
          'data': data,
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
  updateUserPost() {
    // TODO: implement updateUserPost
    throw UnimplementedError();
  }

  updateUserPostStatus(int id) async {
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
          await put('$kHost/api/v1/my-posts/status/${id}', headers: headers);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        responseToBloc.add({
          'errors': false,
          'data': data,
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
}
