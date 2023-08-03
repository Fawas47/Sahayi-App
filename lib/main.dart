import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:sample_47/TOTAL%20STOCK/edit_item.dart';

import 'package:sample_47/firebase/WRAPER.dart';
import 'package:sample_47/firebase/auth.dart';
import 'package:sample_47/firebase/user.dart';
import 'package:sample_47/home.dart';
import 'package:sample_47/login.dart';
import 'package:sizer/sizer.dart';

const SAVED_KEY_NAME = 'userlogin';
final _wrap = wrapper();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

final NavigatorKey = GlobalKey<NavigatorState>();
String UID = 'OrjsUo1F0zWHm9hxQMyJ5HSP2Gj2';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, DeviceType) {
      return MaterialApp(
        navigatorKey: NavigatorKey,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 0, 218, 226),
        ),
        home: splashhome(),
        routes: {
          '/edit': (context) => edit_item_screen(),
        },
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

class mainpage extends StatelessWidget {
  const mainpage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                color: Colors.blue,
              );
            } else
              null;

            if (snapshot.connectionState == ConnectionState.waiting) {
              // return a progress indicator, for example:
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return Homescreen();
            } else {
              return login();
            }
          }),
        ),
      );
}

class splashhome extends StatefulWidget {
  const splashhome({super.key});

  @override
  State<splashhome> createState() => _splashhomeState();
}

class _splashhomeState extends State<splashhome> {
  @override
  void initState() {
    gotohome(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/GIF/sahayi.gif')),
    );
  }
}

Future<void> gotohome(BuildContext ctx) async {
  splashhome();
  await Future.delayed(Duration(seconds: 2));

  Navigator.of(ctx)
      .pushReplacement(MaterialPageRoute(builder: ((context) => mainpage())));
}
