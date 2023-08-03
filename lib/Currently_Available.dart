import 'package:flutter/material.dart';

class available_screen extends StatelessWidget {
  const available_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 117, 201, 119),
      ),
      body: SafeArea(
          child: Center(
        child: Text('CURRENTLY AVAILABLE'),
      )),
    );
  }
}
