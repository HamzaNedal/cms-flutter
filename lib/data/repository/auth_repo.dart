import 'dart:convert';

import 'package:cms/constants.dart';
import 'package:cms/data/model/auth.dart';
import 'package:http/http.dart';

abstract class AuthRepository {
  getUserToken(String email, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  getUserToken(String email, String password) async {
    Map<String, String> headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json',
    };
    var inputField = new Map<String, dynamic>();
    inputField['email'] = email;
    inputField['password'] = password;
    final response =
        await post('$kHost/api/v1/login', headers: headers, body: inputField);
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['error']) {
        return 'Email or Password incorrect';
      }
      return data;
    } else {
      return 'Email or Password incorrect';
    }
  }
}
