import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Components/functions.dart';
import 'package:flutter_firebase_auth/models/user.dart';
import 'package:flutter_firebase_auth/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService authProvider =
        Provider.of<FirebaseAuthService>(context);
    final AppUser user = Provider.of<AppUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          FlatButton(
            onPressed: () {
              authProvider.signOutUser();
            },
            child: Text(
              "Sign out",
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlatButton(
            onPressed: () {
              showErrorDialog(context, "Do you want to delete user",
                  function: () {
                Navigator.of(context).pop();
              });
            },
            child: Text(
              "Delete User",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Email : ${user.userMail}"),
          Text("User Id : ${user.userId}"),
        ],
      )),
    );
  }
}
