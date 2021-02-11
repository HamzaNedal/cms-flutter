import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  double size;
  double marginleft;
  Color color;
  Color cursorColor;
  Color underlineInputBorderColor;
  Color hintStyleColor;
  String hintText;
  String confirm_password;
  bool obscureText;
  Function onSaved;
  Function onChanged;
  Function onFieldSubmitted;
  AuthTextField({
    this.obscureText: false,
    this.size = 300,
    this.marginleft = 0,
    this.color = const Color(0xffFFFFFF),
    this.cursorColor = const Color(0xffFFFFFF),
    this.underlineInputBorderColor = const Color(0xffFFFFFF),
    this.hintStyleColor = const Color(0xffFFFFFF),
    this.hintText = "Email",
    this.confirm_password,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
  });
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
        child: Container(
      margin: EdgeInsets.only(left: getWidth(context, marginleft)),
      width: getWidth(context, size),
      // color: Colors.red,
      child: TextFormField(
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        validator: (value) {
          assert(value != null);
          // print(value);
          if (value.isEmpty) {
            return '${hintText} is empty';
          }
          // print(this.confirm_password);
          if (confirm_password != null) {
            // print("val:" + value);
            // print("con:" + confirm_password);
            if (value != confirm_password) {
              return 'No match';
            }
          }
        },
        style: TextStyle(color: this.color),
        cursorColor: cursorColor,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: this.underlineInputBorderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: this.underlineInputBorderColor),
          ),
          hintStyle: TextStyle(color: this.hintStyleColor),
          hintText: this.hintText,
        ),
      ),
    ));
  }

  getWidth(context, width) {
    var screenWidth = MediaQuery.of(context).size.width;
    var output = screenWidth / width;
    return screenWidth / output;
  }
}
