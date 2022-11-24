// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hive_demo/models/contact.dart';

import '../widgets/update_person_form.dart';
class UpdateScreen extends StatefulWidget {
  final int index;
  final Contact contact;

  const UpdateScreen({super.key, 
    required this.index,
    required this.contact,
  });

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update Contact'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdateContactForm(
          index: widget.index,
          contact: widget.contact,
        ),
      ),
    );
  }
}