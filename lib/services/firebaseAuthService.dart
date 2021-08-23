import 'package:firebase_auth/firebase_auth.dart';
import 'package:haider/models/userModel.dart';

class FirebaseAuthService {
  Future<String> signUpUser(UserModel userModel) async {
    print(userModel.userEmail);
    String response = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.userEmail, password: userModel.userPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return response = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return response = 'The account already exists for that email.';
      }
    } catch (e) {
      return response = e.toString();
    }

    return response = 'User is signed up successfully';
  }

  Future<String> signInUser(UserModel userModel) async {
    print(userModel.userEmail);
    String response = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userModel.userEmail, password: userModel.userPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return response = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return response = 'Wrong password provided for that user.';
      }
    }

    return response = 'User  signed In  successfully';
  }
}
