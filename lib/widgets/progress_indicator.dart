import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  CustomProgressIndicator({this.value, this.backgroundColor});
  final double value;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          value: value,
        ),
      ),
    );
  }
}
