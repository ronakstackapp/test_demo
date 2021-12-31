import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireBaseScreen extends StatefulWidget {
  const FireBaseScreen({Key? key}) : super(key: key);

  @override
  _FireBaseScreenState createState() => _FireBaseScreenState();
}

class _FireBaseScreenState extends State<FireBaseScreen> {



  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}
