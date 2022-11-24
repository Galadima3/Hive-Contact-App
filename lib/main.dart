import 'package:flutter/material.dart';
import 'package:hive_demo/models/contact.dart';
import 'package:hive_demo/screens/info_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {// Initialize hive
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(ContactAdapter());
  // Opening the box
  await Hive.openBox('peopleBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const InfoScreen(),
    );
  }
}

