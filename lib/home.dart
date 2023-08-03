import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:sample_47/Currently_Available.dart';
import 'package:sample_47/CASH/cash.dart';
import 'package:sample_47/delivery.dart';
import 'package:sample_47/records.dart';
import 'package:sample_47/return.dart';
import 'package:sample_47/TOTAL%20STOCK/total_stock.dart';
import 'package:sample_47/in_use.dart';
import 'package:sample_47/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool internet = false;
  @override
  @override
  void initState() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
    });
    setState(() {
      this.internet = internet;
    });
  }

  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 5, 134),
        title: Text('HOME'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        actions: [
          PopupMenuButton<int>(
            color: Color.fromARGB(255, 130, 130, 131),
            itemBuilder: ((context) => [
                  PopupMenuItem<int>(
                    padding: EdgeInsets.all(8),
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text('LogOut',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  )
                ]),
            onSelected: (int) => FirebaseAuth.instance.signOut(),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: double.infinity.w,
                height: 30.h,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/IMAGE/HOME LOG.jpg'),
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.cover)),
              ),
              Flexible(
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity.w,
                      height: 72.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/IMAGE/a0.jpg'))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        //DELIVERY
                                        alignment: Alignment.topRight,
                                        width: 90.w,
                                        height: 11.h,
                                        margin: EdgeInsets.all(12),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/IMAGE/DELIVERY.jpg'),
                                              fit: BoxFit.cover),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                spreadRadius: 2,
                                                blurRadius: 5)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onTap: () async {
                                        internet =
                                            await InternetConnectionChecker()
                                                .hasConnection;
                                        final String text;
                                        if (internet) {
                                          text = 'NO INTERNET CONNECTION';
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      delivery_screen())));
                                        } else {
                                          text = 'NO INTERNET CONNECTION';
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(10),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 27, 27, 27),
                                                  content: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        "$text",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                        child: Container(
                                          //RETURN
                                          alignment: Alignment.topRight,
                                          width: 90.w,
                                          height: 11.h,
                                          margin: EdgeInsets.all(12),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/IMAGE/RETURN1.jpg'),
                                                fit: BoxFit.cover),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  spreadRadius: 2,
                                                  blurRadius: 5)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onTap: () async {
                                          internet =
                                              await InternetConnectionChecker()
                                                  .hasConnection;
                                          final String text;
                                          if (internet) {
                                            text = 'NO INTERNET CONNECTION';
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        return_screen())));
                                          } else {
                                            text = 'NO INTERNET CONNECTION';
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(10),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 27, 27, 27),
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "$text",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )));
                                          }
                                        }),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                //CURRENTLY AVAILABLE
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    width: 38.w,
                                    height: 12.h,
                                    margin: EdgeInsets.all(12),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/IMAGE/CURUNT.jpg'),
                                          fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 5)
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onTap: () async {
                                    internet = await InternetConnectionChecker()
                                        .hasConnection;
                                    final String text;
                                    if (internet) {
                                      text = 'NO INTERNET CONNECTION';
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  available_screen())));
                                    } else {
                                      text = 'NO INTERNET CONNECTION';
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(10),
                                              backgroundColor: Color.fromARGB(
                                                  255, 27, 27, 27),
                                              content: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    "$text",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )));
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                    child: Container(
                                      //IN USE
                                      width: 38.w,
                                      height: 12.h,
                                      margin: EdgeInsets.all(12),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/IMAGE/IN USE.jpg')),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              spreadRadius: 2,
                                              blurRadius: 5)
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onTap: () async {
                                      internet =
                                          await InternetConnectionChecker()
                                              .hasConnection;
                                      final String text;
                                      if (internet) {
                                        text = 'NO INTERNET CONNECTION';
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    in_use_screen())));
                                      } else {
                                        text = 'NO INTERNET CONNECTION';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(10),
                                                backgroundColor: Color.fromARGB(
                                                    255, 27, 27, 27),
                                                content: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "$text",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )));
                                      }
                                    })
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                        child: Container(
                                          //STOCK
                                          alignment: Alignment.topRight,
                                          width: 38.w,
                                          height: 12.h,
                                          margin: EdgeInsets.all(12),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/IMAGE/TOTAL.jpg')),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  spreadRadius: 2,
                                                  blurRadius: 5)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onTap: () async {
                                          internet =
                                              await InternetConnectionChecker()
                                                  .hasConnection;
                                          final String text;
                                          if (internet) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        total_stock_screen())));
                                          } else {
                                            text = 'NO INTERNET CONNECTION';
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(10),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 27, 27, 27),
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "$text",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )));
                                          }
                                        }),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                        child: Container(
                                          //CASH
                                          width: 38.w,
                                          height: 12.h,
                                          margin: EdgeInsets.all(12),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/IMAGE/CASH.jpg')),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  spreadRadius: 2,
                                                  blurRadius: 5)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onTap: () async {
                                          internet =
                                              await InternetConnectionChecker()
                                                  .hasConnection;
                                          final String text;
                                          if (internet) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        cash_screen())));
                                          } else {
                                            text = 'NO INTERNET CONNECTION';
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(10),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 27, 27, 27),
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "$text",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )));
                                          }
                                        })
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        //records
                                        alignment: Alignment.topRight,
                                        width: 86.w,
                                        height: 10.h,
                                        margin: EdgeInsets.all(12),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/IMAGE/REC.jpg'),
                                              fit: BoxFit.cover),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                spreadRadius: 2,
                                                blurRadius: 5)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onTap: () async {
                                        internet =
                                            await InternetConnectionChecker()
                                                .hasConnection;
                                        final String text;
                                        if (internet) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      records_screen())));
                                        } else {
                                          text = 'NO INTERNET CONNECTION';
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(10),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 27, 27, 27),
                                                  content: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        "$text",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

selecteditem(BuildContext context, item) {
  switch (item) {
    case 0:
      signout(context);
      break;
  }
}

signout(BuildContext ctx) async {
  final _sharedprefs = await SharedPreferences.getInstance();
  await _sharedprefs.clear();

  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => login()), (route) => false);
}
