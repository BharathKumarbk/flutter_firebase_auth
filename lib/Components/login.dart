import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Components/constants.dart';
import 'package:flutter_firebase_auth/Components/functions.dart';
import 'package:flutter_firebase_auth/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMsg;

  bool isLoading = true;

  void clear() {
    setState(() {
      emailController.text = "";
      passwordController.text = "";
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        key: _formState,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: formDecoration.copyWith(hintText: "E mail"),
              validator: (value) {
                if (!emailValidate(value)) {
                  return "Please provide valid email";
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
                if (value.isEmpty) {
                  return "Fiels should not be empty";
                } else if (value.length < 5) {
                  return "password is too small ( Minimum 6 characters required )";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(errorMsg ?? ""),
            isLoading
                ? RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Text('Yay! A SnackBar!'),
                        action: SnackBarAction(
                          label: "$errorMsg",
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                      if (_formState.currentState.validate()) {
                        authProvider
                            .signInUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          if (authProvider.firebaseAuthException.code ==
                              "user-not-found") {
                            showErrorDialog(context, "E - mail does not exist");
                            clear();
                          } else if (authProvider.firebaseAuthException.code ==
                              "wrong-password") {
                            showErrorDialog(context, "Password incorrect");
                            clear();
                          } else {
                            return null;
                          }
                          setState(() {
                            isLoading = true;
                          });
                        });
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
