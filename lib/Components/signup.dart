import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Components/constants.dart';
import 'package:flutter_firebase_auth/Components/functions.dart';
import 'package:flutter_firebase_auth/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formStateSignUp = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  String errorMsg;

  error(String error) {
    setState(() {
      errorMsg = error;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService authProvider =
        Provider.of<FirebaseAuthService>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formStateSignUp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: formDecoration.copyWith(hintText: "E mail"),
              validator: (value) {
                if (!emailValidate(value)) {
                  return "Please provide valid email";
                } else if (value.length < 5) {
                  return "password is too small ( Minimum 6 characters required )";
                } else if (value.isEmpty) {
                  return "Field should not be empty";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: passwordController,
              decoration: formDecoration.copyWith(hintText: "Password"),
              validator: (value) {
                return value.isEmpty ? "Field should not be empty" : null;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: retypePasswordController,
              decoration: formDecoration.copyWith(hintText: "Retype Password"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Fiels should not be empty";
                } else if (value.length < 5) {
                  return "password is too small ( Minimum 6 characters required )";
                } else if (passwordController.text !=
                    retypePasswordController.text) {
                  return "Passwords did not match";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
                onPressed: () {
                  setState(() {
                    emailController.text = "";
                    passwordController.text = "";
                    retypePasswordController.text = "";
                  });
                },
                child: Text("clear")),
            Text(errorMsg ?? ""),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                if (_formStateSignUp.currentState.validate()) {
                  authProvider
                      .createWithEmailAndPassword(
                          email: emailController.text,
                          password: retypePasswordController.text)
                      .then((value) {
                    if (authProvider.firebaseAuthException.code ==
                        "email-already-in-use") {
                      error("email-already-in-use");
                    }
                  });
                }
              },
              child: Text(
                "SignUp",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
