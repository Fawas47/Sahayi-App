import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sample_47/TOTAL%20STOCK/add_items.dart';
import 'package:sample_47/TOTAL%20STOCK/edit_item.dart';

class total_stock_screen extends StatefulWidget {
  total_stock_screen({Key? key}) : super(key: key) {}

  @override
  State<total_stock_screen> createState() => _total_stock_screenState();
}

class _total_stock_screenState extends State<total_stock_screen> {
  CollectionReference stock =
      FirebaseFirestore.instance.collection('total stock');

  late PickedFile _imageFile;

  bool internet = false;

  final ImagePicker _picker = ImagePicker();

  File? image;

  final db = FirebaseFirestore.instance;

  late DocumentReference _ref;

  late Stream<QuerySnapshot> _streamdata;

  late Map data;

  @override
  initState() {
    super.initState();
    _streamdata = stock.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TOTAL STOCK'),
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          backgroundColor: Color.fromARGB(255, 209, 125, 0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            internet = await InternetConnectionChecker().hasConnection;
            final String text;
            if (internet) {
              text = 'NO INTERNET CONNECTION';
              showaddpop(context);
            } else {
              text = 'NO INTERNET CONNECTION';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  backgroundColor: Color.fromARGB(255, 27, 27, 27),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )));
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/IMAGE/a0.jpg'))),
            child: StreamBuilder<QuerySnapshot>(
              stream: stock.orderBy('name').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot item = snapshot.data.docs[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: 340,
                              height: 105,
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 3, 138, 156),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: ListTile(
                                  onLongPress: () {
                                    Navigator.pushNamed(context, '/edit',
                                        arguments: {
                                          'name': item['name'],
                                          'number': item['number'],
                                          'img': item['img'],
                                          'id': item.id,
                                        });
                                  },
                                  dense: true,
                                  visualDensity: VisualDensity(vertical: 4),
                                  title: Text(
                                    item['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        letterSpacing: 1,
                                        color: Colors.white),
                                  ),
                                  trailing: Container(
                                    child: Text(
                                      item['number'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 1,
                                          color: Colors.white),
                                    ),
                                  ),
                                  leading: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 110,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          item['img'],
                                          fit: BoxFit.fill,
                                          width: 80,
                                          height: 120,
                                        )),
                                  ),
                                ),
                              )),
                        ],
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Some error occured ${snapshot.error}'),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )));
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((e) => {
              'itemname': e['name'],
              'itemnumber': e['number'],
              'itemimage': e['image']
            })
        .toList();

    return listItems;
  }
}

Future<void> showaddpop(BuildContext context) async {
  showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 56, 56, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      context: context,
      builder: ((builder) => Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                Text(
                  'ADD ITEMS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Divider(
                  thickness: 5,
                ),
                SizedBox(
                  height: 6,
                ),
                InkWell(
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.add,
                                  size: 30,
                                  color: Color.fromARGB(255, 62, 135, 245)),
                              Text(
                                'Add Item',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 68, 113, 236)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => add_item_screen())));
                    }),
              ],
            ),
          )));
}

class User {
  String id;
  String? name;
  String? number;
  var image;

  User({
    this.id = '',
    this.name,
    this.number,
    this.image,
  });

  Map<String, dynamic> tojson() => {
        'id': id,
        'name': name,
        'number': number,
        'img': image,
      };
  static User fromjson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      image: json['img']);
}
