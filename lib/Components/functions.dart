import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool emailValidate(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(email);
}

void showErrorDialog(BuildContext context, String error, {Function function}) {
// flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
// return object of type Dialog
      return AlertDialog(
        title: new Text("$error"),
        actions: <Widget>[
// usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Yes"),
            onPressed: function,
          ),
        ],
      );
    },
  );
}
