import 'package:cms/constants.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CircularProgressIndicator(
      backgroundColor: kAppBarColor,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ));
  }
}
