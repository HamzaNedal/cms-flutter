import 'package:cms/blocs/auth/auth_bloc.dart';
import 'package:cms/constants.dart';
import 'package:cms/widgets/authTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    var bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            UnconstrainedBox(
                child: Container(
              margin: EdgeInsets.only(
                  right: getWidth(context, 180), top: getWidth(context, 150)),
              width: getWidth(context, 150),
              child: Text(
                "Welcome Back.",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            )),
            SizedBox(
              height: getWidth(context, 40),
            ),
            AuthTextField(
              size: 340,
              marginleft: 10,
              onSaved: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: getWidth(context, 30),
            ),
            AuthTextField(
              size: 340,
              marginleft: 10,
              hintText: 'Password',
              obscureText: true,
              onSaved: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: getWidth(context, 30),
            ),
            UnconstrainedBox(
                child: Container(
              width: getWidth(context, 300),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoadingState) {
                    print("Loading ...");
                  } else if (state is AuthLoginSuccessState) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (state is AuthLoginErrorState) {
                    print(state.messge);
                  }
                },
                child: RaisedButton(
                  color: Color(0xff3BBCF8),
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      bloc.add(LoginEvent(email, password));
                    }
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
            )),
            SizedBox(
              height: getWidth(context, 30),
            ),
            UnconstrainedBox(
              child: Container(
                margin: EdgeInsets.only(top: getHeight(context, 38), left: 20),
                child: Row(
                  children: <Widget>[
                    Text("Don't have an account? ",
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        return Navigator.pushNamed(context, '/signup');
                      },
                      child: Text("Signup",
                          style: TextStyle(color: Color(0xff3BBCF8))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getWidth(context, width) {
    var screenWidth = MediaQuery.of(context).size.width;
    var output = screenWidth / width;
    return screenWidth / output;
  }

  getHeight(context, height) {
    var screenHeight = MediaQuery.of(context).size.height;
    var output = screenHeight / height;
    return screenHeight / output;
  }
}
