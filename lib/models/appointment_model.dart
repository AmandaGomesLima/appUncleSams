import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
final apptCollection = db.collection('appointments');

enum Service {
  pending,
  done,
  canceled
}

Map<Service, String> serviceName = {
  Service.pending: 'pendente',
  Service.done: 'concluído',
  Service.canceled: 'cancelado'
};

class Appointment {
  final String userId;
  final String name;
  final String service;
  final DateTime time;
  final String status;
  final String? id;

  Appointment({
    required this.userId,
    required this.name,
    required this.time,
    required this.service,
    required this.status,
    required this.id
  });

  set status(String value) {
    status = value;
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      userId: json['user_id'],
      name: json['name'],
      service: json['service'],
      time: (json['time']).toDate(),
      status: json['status'],
      id: json['id']
    );
  }

  toJson() {
    return {
      'user_id': userId,
      'name': name,
      'service': service,
      'time': time,
      'status': status,
      'id': id
    };
  }
}