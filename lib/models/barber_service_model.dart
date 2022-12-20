import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
final bservicesCollection = db.collection('services');

class BarberService {
  final String name;

  BarberService({
    required this.name
  });

  set status(String value) {
    status = value;
  }

  factory BarberService.fromJson(Map<String, dynamic> json) {
    return BarberService(
        name: json['name']
    );
  }

  toJson() {
    return {
      'name': name
    };
  }
}