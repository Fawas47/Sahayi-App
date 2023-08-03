import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class return_screen extends StatelessWidget {
  const return_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 175, 2, 2),
      ),
      body: SafeArea(
          child: Center(
        child: Text('return'),
      )),
    );
  }
}
