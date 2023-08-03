import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class add_item_screen extends StatefulWidget {
  const add_item_screen({super.key});

  @override
  State<add_item_screen> createState() => _add_item_screenState();
}

bool internet = false;
final _formkey = GlobalKey<FormState>();

class _add_item_screenState extends State<add_item_screen> {
  late PickedFile _imageFile;

  final itemnumber = TextEditingController();
  final itemname = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? image;
  UploadTask? uploadTask;
  Uint8List? fileBytes;
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('total stock');
  CollectionReference _current =
      FirebaseFirestore.instance.collection('Currently Available');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ADD ITEM',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          backgroundColor: Color.fromARGB(255, 6, 94, 177),
        ),
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/IMAGE/EW.jpg'),
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.cover)),
                child: ListView(children: [
                  SizedBox(),
                  bottom(context),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: itemname,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            autocorrect: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Data Empty';
                              } else {
                                return null;
                              }
                            },
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(left: 30),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 238, 238, 238))),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: new BorderSide(
                                    color: Color.fromARGB(255, 0, 65, 185)),
                              ),
                              hintText: "ITEM NAME",
                              labelText: 'ITEM NAME',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 182, 179, 179)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      controller: itemnumber,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      autocorrect: true,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 238, 238, 238))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: new BorderSide(
                              color: Color.fromARGB(255, 0, 65, 185)),
                        ),
                        hintText: "ITEM NUMBER",
                        labelText: 'ITEM NUMBER',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 182, 179, 179)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 19,
                        ),
                        SizedBox(
                          width: 120,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            child: const Text('CANCEL'),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        SizedBox(
                          width: 120,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              internet = await InternetConnectionChecker()
                                  .hasConnection;
                              final String text;
                              if (internet) {
                                text = 'NO INTERNET CONNECTION';
                                if (_formkey.currentState!.validate()) {
                                  UPLOADTASK(context);
                                }
                              } else {
                                text = 'NO INTERNET CONNECTION';
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                        backgroundColor:
                                            Color.fromARGB(255, 27, 27, 27),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )));
                              }
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            child: const Text('ADD ITEM'),
                          ),
                        ),
                      ],
                    ),
                  )
                ]))));
  }

  Future createuser({required String name, String? amg, String? num}) async {
    final docuser = FirebaseFirestore.instance.collection('total stock').doc();
    final avaluser =
        FirebaseFirestore.instance.collection('Currently Available').doc();
    final user = User(
      id: docuser.id,
      name: name,
      imageUrl: amg,
      Number: num,
    );
    if (user.imageUrl == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('UPLOAD IMAGE ')));
    } else {
      Navigator.of(context).pop();

      final json = user.tojson();

      await docuser.set(json);
      await avaluser.set(json);
    }
    ;
  }

  Future<Widget> buildupload() async => StreamBuilder<TaskSnapshot>(
      stream: uploadTask!.snapshotEvents,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          double progress =
              snap.bytesTransferred.toDouble() / snap.totalBytes.toDouble();
          return SizedBox(
            child: Stack(fit: StackFit.expand, children: [
              Center(
                child: LinearProgressIndicator(
                  value: progress,
                ),
              ),
              Center(
                child: Text('${(100 * progress).roundToDouble()}%'),
              )
            ]),
          );
        } else {
          return const SizedBox();
        }
      }));

  Future takephoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed to exep$e');
    }
  }

  final _total = add_item_screen();
  late File imageFile;

  Widget bottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Container(
        width: 15.w,
        height: 25.h,
        child: InkWell(
          onTap: () {
            setState(
              () => showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet())),
            );
          },
          child: Center(
            child: Column(
              children: [
                if (image != null)
                  ClipOval(
                    child: Image.file(
                      image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  ClipOval(child: Image.asset('assets/IMAGE/ADD IMAGE.jpg'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 110.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 90,
              ),
              Text(
                "Choose Item Photo",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              Navigator.of(context).pop();

              takephoto();
            },
            child: Column(
              children: [
                Icon(
                  Icons.image,
                  size: 40,
                ),
                Text('Gallery'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future UPLOADTASK(BuildContext context) async {
    if (image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('UPLOAD IMAGE !')));
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) => Center(
                child: CircularProgressIndicator(),
              )));
      String uniquename = DateTime.now().microsecondsSinceEpoch.toString();

      //  get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();

      Reference referenceDirImage = referenceRoot.child('image');

//  create a referene for image to be stored

      Reference referenceImagetoUpload = referenceDirImage.child(uniquename);

      try {
        uploadTask = referenceImagetoUpload.putFile(File(image!.path));

        // SUCCESS: GET THE DOWNLOAD URL
        final snapshot = await uploadTask!.whenComplete(() {
          Navigator.of(context).pop();
        });
        final store = await referenceImagetoUpload.getDownloadURL();
        setState(() {
          uploadTask = null;
        });

        final name = itemname.text;
        final number = itemnumber.text;
        createuser(name: name, amg: store, num: number);
      } catch (e) {}
    }
  }
}

class User {
  String id;
  final String? name;
  final String? Number;
  String? imageUrl = '';

  User({
    this.id = '',
    this.name,
    this.imageUrl,
    this.Number,
  });

  Map<String, dynamic> tojson() => {
        'id': id,
        'name': name,
        'number': Number,
        'img': imageUrl,
      };
}
