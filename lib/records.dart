import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class records_screen extends StatelessWidget {
  const records_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 113, 0),
      ),
      body: SafeArea(
          child: Center(
        child: Text('records'),
      )),
    );
  }
}
