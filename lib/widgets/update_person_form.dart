import 'package:flutter/material.dart';
import 'dart:developer';


import 'package:hive_demo/models/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';




class UpdateContactForm extends StatefulWidget {
  final int index;
  final Contact contact;
  const UpdateContactForm({super.key, required this.index, required this.contact});

  @override
  State<UpdateContactForm> createState() => _UpdateContactFormState();
}

class _UpdateContactFormState extends State<UpdateContactForm> {
  late var _nameController = TextEditingController();
  late var _numberController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;
  _updateInfo() {
    Contact newContact= Contact(
      name: _nameController.text,
      number: int.parse(_numberController.text),
    );
    box.putAt(widget.index, newContact);
    log('Info updated in box!');
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
    box = Hive.box('peoplebox');
    _nameController = TextEditingController(text: widget.contact.name);
    _numberController = TextEditingController(text: widget.contact.number.toString());

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
                    _updateInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Update'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

