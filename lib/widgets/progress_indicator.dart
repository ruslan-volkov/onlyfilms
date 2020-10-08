import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  CustomProgressIndicator({this.value});
  final double value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).splashColor,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          value: value,
        ),
      ),
    );
  }
}
