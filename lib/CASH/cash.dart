import 'package:flutter/material.dart';

import 'package:sample_47/CASH/expence.dart';
import 'package:sample_47/CASH/income.dart';
import 'package:sizer/sizer.dart';

class cash_screen extends StatelessWidget {
  const cash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CASH'),
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          backgroundColor: Color.fromARGB(255, 145, 158, 24),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 22, 27, 41),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            child: Container(
                              //INCOME
                              alignment: Alignment.bottomRight,
                              width: 89.w,
                              height: 40.h,
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/IMAGE/INCOME1.jpg'),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => income_screen())));
                            }),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            child: Container(
                              //EXPENCE
                              alignment: Alignment.bottomRight,
                              width: 89.w,
                              height: 40.h,
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/IMAGE/EXPENCE1.jpg'),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => expence_screen())));
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
