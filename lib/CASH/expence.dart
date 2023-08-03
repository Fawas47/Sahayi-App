import 'package:flutter/material.dart';

class expence_screen extends StatelessWidget {
  const expence_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EXPENCE'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        backgroundColor: Color.fromARGB(255, 165, 0, 0),
      ),
      body: SafeArea(
          child: Center(
        child: Text('expence'),
      )),
    );
  }
}
