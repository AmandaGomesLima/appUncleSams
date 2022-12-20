import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uncle_sam/models/appointment_model.dart';
import 'package:uncle_sam/widget/user_schedule_card.dart';

getAppointments() async {
  return apptCollection.snapshots();
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Agendamentos'),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: SizedBox(
        child: StreamBuilder(
          stream: apptCollection.where('user_id', isEqualTo: user.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Ops! Aconteceu algum erro nos Agendamentos.');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null || !snapshot.hasData) {
              return const SizedBox();
            }
            if (snapshot.data!.docs.isEmpty) {
              return const SizedBox(
                child: Center(
                    child:
                    Text('Você não tem nenhum serviço agendado!')
                ),
              );
            }

            List<Appointment> apptList = [];

            for (var doc in snapshot.data!.docs) {
              final appt = Appointment.fromJson(doc.data() as Map<String, dynamic>);
              apptList.add(appt);
            }

            apptList.sort((a,b)=> b.time.compareTo(a.time));

            return ListView.builder(
              itemCount: apptList.length,
              itemBuilder: (context, index) {
                return UserScheduleCard(apptList[index]);
              },
            );
          },
        )
      )
    )
  );
}
