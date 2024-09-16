import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  const MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: Colors.green.shade300,
          border: Border.all(width: 6, color: Colors.green.shade500),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
