import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_auth/Screens/root.dart';
import 'package:flutter_firebase_auth/models/user.dart';
import 'package:flutter_firebase_auth/services/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Firebase error"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(providers: [
              StreamProvider<AppUser>.value(
                value: FirebaseAuthService().user,
                catchError: (c, o) {
                  return;
                },
              ),
              ChangeNotifierProvider<FirebaseAuthService>(
                create: (_) => FirebaseAuthService(),
              )
            ], child: Root());
          }
          return Scaffold(
            body: Center(
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("Firebase error")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
