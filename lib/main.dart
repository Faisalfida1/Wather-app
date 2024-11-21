import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import "../Screen/login_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA_BAkB8MODeNQcTsLnQimlrT2pJnaK_Zs",
      authDomain: "fir-wather-app.firebaseapp.com",
      projectId: "fir-wather-app",
      storageBucket: "fir-wather-app.firebasestorage.app",
      messagingSenderId: "581229282242",
      appId: "1:581229282242:web:7d47342cd20af8205c4c5b",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}