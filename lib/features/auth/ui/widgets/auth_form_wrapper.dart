import 'package:flutter/material.dart';

class AuthFormWrapper extends StatelessWidget {
  final Form form;
  const AuthFormWrapper({required this.form});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: deviceWidth * 0.6,
        child: this.form,
      ),
    );
  }
}
