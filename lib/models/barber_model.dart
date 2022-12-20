import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
final barbersCollection = db.collection('barbers');

class Barber {
  final String name;

  Barber({
    required this.name
  });

  set status(String value) {
    status = value;
  }

  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
        name: json['name']
    );
  }

  toJson() {
    return {
      'name': name
    };
  }
}