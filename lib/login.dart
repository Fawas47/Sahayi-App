import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:sample_47/firebase/auth.dart';
import 'package:sample_47/firebase/user.dart';
import 'package:sample_47/home.dart';
import 'package:sample_47/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _datamatched = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  String UID = 'OrjsUo1F0zWHm9hxQMyJ5HSP2Gj2';
  String Email = '';
  String Password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _fire = AuthService();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/IMAGE/a2.jpg',
              ),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Image.asset('assets/IMAGE/AWA.png'),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    autocorrect: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data Empty';
                      } else {
                        return null;
                      }
                    },
                    controller: usernameController,
                    onChanged: ((val) {
                      setState(() => Email = val);
                    }),
                    decoration: new InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      filled: true,
                      fillColor: Color.fromARGB(69, 0, 145, 202),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 214, 196))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: new BorderSide(
                            color: Color.fromARGB(255, 0, 65, 185)),
                      ),
                      hintText: "username",
                      labelText: 'USER ID',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      autofocus: false,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' Data Empty';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      onChanged: ((value) {
                        setState(() => Password = value);
                      }),
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Color.fromARGB(69, 0, 217, 255),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 194, 243),
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "password",
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)))),
              onPressed: (() async {
                if (_formkey.currentState!.validate()) {
                  signIn(context);
                  FirebaseAuth.instance.authStateChanges().listen(
                    (User? user) {
                      if (User != null || user!.uid == UID) {
                        print(user!.uid);
                        Homescreen();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(10),
                            backgroundColor: Color.fromARGB(255, 27, 27, 27),
                            content: Text("username password dosnt match")));
                      }
                    },
                  );

                  print(Email);
                  print(Password);
                }
              }),
              child: const Text('LOGIN'),
            )
          ]),
        ),
      ),
    ));
  }

  Future signIn(BuildContext ctx) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => Center(
              child: CircularProgressIndicator(),
            )));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Color.fromARGB(255, 27, 27, 27),
          content: Text(
            "Username Password dosn't match",
            style: TextStyle(fontWeight: FontWeight.bold),
          )));
    }

    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
