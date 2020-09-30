import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthException _firebaseAuthException;

  FirebaseAuthException get firebaseAuthException => _firebaseAuthException;

  void setFirebaseAuthException(FirebaseAuthException exception) {
    _firebaseAuthException = exception;
  }

  Stream<AppUser> get user {
    return firebaseAuth.authStateChanges().map((user) {
      try {
        return user.uid != null
            ? AppUser(
                userId: user.uid,
                userMail: user.email,
                userName: user.displayName,
                userUrl: user.photoURL,
              )
            : null;
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<void> deleteUser() async {
    try {
      await firebaseAuth.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      setFirebaseAuthException(e);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInUserWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      setFirebaseAuthException(e);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOutUser() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      setFirebaseAuthException(e);
    } catch (e) {
      print(e.toString());
    }
  }
}
