import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:provider/provider.dart';
import 'package:sample_47/home.dart';
import 'package:sample_47/login.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final usermodel = Provider.of(context);

    if (usermodel == null) {
      return login();
    } else {
      return Homescreen();
    }
  }
}
