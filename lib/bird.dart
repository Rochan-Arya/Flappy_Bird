import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80, height: 80, child: Image.asset("lib/images/bird.png"));
  }
}
