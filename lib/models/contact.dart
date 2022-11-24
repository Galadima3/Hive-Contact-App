import 'package:hive_flutter/hive_flutter.dart';
part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int number;

  Contact({
    required this.name,
    required this.number,
  });
}