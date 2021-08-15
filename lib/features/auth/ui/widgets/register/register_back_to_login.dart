import 'package:flutter/material.dart';

class RegisterBackToLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        Text(
          'Come back to login page',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
