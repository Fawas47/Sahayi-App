import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_47/firebase/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  youser? userfromfire(User user) {
    if (user != null) {
      youser(uid: user.uid);
    } else {
      print('null');
      return null;
    }
  }

  Future storevalue(String Email, String Password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: Email, password: Password);
      User? fire = userCredential.user;
      return userfromfire(fire!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  modeluser? model(User model) {
    if (model != null) {
      modeluser(aaa: model.uid);
    } else {
      print('null');
    }
  }
}
