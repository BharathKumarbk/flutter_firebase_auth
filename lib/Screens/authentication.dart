import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Components/login.dart';
import 'package:flutter_firebase_auth/Components/signup.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool asAccount = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( asAccount ? "Login" : "SignUp"),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              setState(() {
                asAccount = !asAccount;
              });
            },
            child: Text(
              asAccount ?  "Sign up" : "Log in",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: asAccount ? Login() : SignUp(),
    );
  }
}
