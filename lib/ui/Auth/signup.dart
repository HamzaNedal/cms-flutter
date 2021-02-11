import 'package:cms/constants.dart';
import 'package:cms/widgets/authTextField.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            UnconstrainedBox(
                child: Container(
              margin: EdgeInsets.only(
                  right: getWidth(context, 180), top: getWidth(context, 100)),
              width: getWidth(context, 150),
              child: Text(
                "Create Account.",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            )),
            SizedBox(
              height: getWidth(context, 30),
            ),
            AuthTextField(
              size: 340,
              marginleft: 10,
              hintText: "Name",
            ),
            SizedBox(
              height: getWidth(context, 10),
            ),
            AuthTextField(
              size: 340,
              marginleft: 10,
            ),
            SizedBox(
              height: getWidth(context, 10),
            ),
            AuthTextField(
              size: 340,
              marginleft: 10,
              obscureText: true,
              hintText: 'Password',
              onSaved: (value) {
                this.password = value;
              },
            ),
            SizedBox(
              height: getWidth(context, 10),
            ),
            AuthTextField(
              size: 340,
              marginleft: 10,
              obscureText: true,
              hintText: 'Confirm password',
              confirm_password: this.password,
            ),
            SizedBox(
              height: getWidth(context, 20),
            ),
            UnconstrainedBox(
                child: Container(
              width: getWidth(context, 300),
              child: RaisedButton(
                color: Color(0xff3BBCF8),
                onPressed: () {
                  _globalKey.currentState.save();
                  if (_globalKey.currentState.validate()) {}
                },
                child: Text('Sign up', style: TextStyle(color: Colors.white)),
              ),
            )),
            UnconstrainedBox(
              child: Container(
                margin: EdgeInsets.only(top: getHeight(context, 38), left: 20),
                child: Row(
                  children: <Widget>[
                    Text("Already have an account? ",
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        return Navigator.pushReplacementNamed(
                            context, '/login');
                      },
                      child: Text("Login",
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
