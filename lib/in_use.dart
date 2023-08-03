import 'package:flutter/material.dart';

class in_use_screen extends StatelessWidget {
  const in_use_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 201, 127, 117),
      ),
      body: SafeArea(
          child: Center(
        child: Text('IN Use'),
      )),
    );
  }
}
