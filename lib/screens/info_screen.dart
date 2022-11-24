// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_demo/screens/add_screen.dart';
import 'package:hive_demo/screens/update_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final Box contactBox;

  // Delete info from people box
  _deleteInfo(int index) {
    contactBox.deleteAt(index);
    log('Item deleted from box at index: $index');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    contactBox = Hive.box('peopleBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No Contact..'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                var personData = currentBox.getAt(index)!;
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdateScreen(
                        index: index,
                        contact: personData,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(personData.name),
                    subtitle: Text('+234${personData.number.toString()}'),
                    trailing: IconButton(
                      onPressed: () => _deleteInfo(index),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
