import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cms/data/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.repo) : super(AuthInitialState());
  AuthRepository repo;
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
    if (event is LoginEvent) {
      yield AuthLoadingState();
      var data = await repo.getUserToken(event.email, event.password);
      if (data != 'Email or Password incorrect') {
        await pref.setString('access_token', data['access_token']);
        await pref.setString('username', data['username']);
        await pref.setString('name', data['name']);
        await pref.setString('email', data['email']);
        await pref.setString('image', data['image']);
        yield AuthLoginSuccessState();
      } else {
        yield AuthLoginErrorState(messge: data);
      }
    }
  }
}
