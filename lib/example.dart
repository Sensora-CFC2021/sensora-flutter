import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  String value;
  Example(this.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(value),
      ),
    );
  }
}
