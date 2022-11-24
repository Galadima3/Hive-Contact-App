// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_demo/models/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddPersonForm extends StatefulWidget {
  const AddPersonForm({Key? key}) : super(key: key);
  @override
  _AddPersonFormState createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;
  _addInfo() async {
    Contact newContact = Contact(
        name: _nameController.text.trim(),
        number: int.parse(_numberController.text));
    box.add(newContact);
    log('Contact Saved');
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('peopleBox');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _personFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Name'),
          TextFormField(
            controller: _nameController,
            validator: _fieldValidator,
          ),
          const SizedBox(height: 24.0),
          const Text('Phone Number'),
          TextFormField(
            controller: _numberController,
            validator: _fieldValidator,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_personFormKey.currentState!.validate()) {
                    _addInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
