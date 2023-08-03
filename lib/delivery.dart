import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class delivery_screen extends StatelessWidget {
  const delivery_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 31, 189, 0),
        ),
        body: SafeArea(
          child: Center(),
        ));
  }
}
