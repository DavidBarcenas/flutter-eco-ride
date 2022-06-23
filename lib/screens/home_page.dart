import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: MaterialButton(
        height: 50,
        minWidth: 300,
        color: Colors.green,
        child: const Text('Test connection'),
        onPressed: () {
          DatabaseReference dbref = FirebaseDatabase.instance.ref('test');
          dbref.set('success');
        },
      )),
    );
  }
}
