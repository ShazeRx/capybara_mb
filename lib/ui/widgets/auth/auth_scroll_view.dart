import 'package:flutter/material.dart';

class AuthScrollView extends StatelessWidget {
  final List<Widget> children;

  const AuthScrollView({required this.children});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: this.children,
          ),
        )
      ],
    );
  }
}
