import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/Screens/authentication.dart';
import 'package:flutter_firebase_auth/Screens/home_page.dart';
import 'package:flutter_firebase_auth/models/user.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    final AppUser appUser = Provider.of<AppUser>(context);
    return appUser != null ? HomePage() : Authentication();
  }
}
