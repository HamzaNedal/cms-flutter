import 'dart:convert';

import 'package:cms/constants.dart';
import 'package:cms/data/model/get_post_comments.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostCommentsRepo {
  getComments(String slug);
}

class CommentsImp extends PostCommentsRepo {
  @override
  getComments(String slug) async {
    final pref = await SharedPreferences.getInstance();
    List responseToBloc = [];
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
    ;
    final response =
        await get('$kHost/api/v1/show-post-comments/$slug', headers: headers);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data = GetPostCommets.fromJson(data);
      responseToBloc.add({'errors': false, 'data': data});
      return responseToBloc;
    } else {
      responseToBloc.add({'errors': true, 'data': 'No comment founded'});
      return responseToBloc;
    }
  }
}
