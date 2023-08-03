import 'package:flutter/material.dart';

class income_screen extends StatelessWidget {
  const income_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INCOME'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        backgroundColor: Color.fromARGB(255, 30, 150, 0),
      ),
      body: SafeArea(
          child: Center(
        child: Text('income'),
      )),
    );
  }
}
