import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:time_picker_widget/time_picker_widget.dart';
import 'package:uncle_sam/models/appointment_model.dart';
import 'package:uncle_sam/models/barber_model.dart';
import 'package:uncle_sam/models/barber_service_model.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Stream<QuerySnapshot> barberRecords = barbersCollection.snapshots();
  final Stream<QuerySnapshot> serviceRecords = bservicesCollection.snapshots();
  final List<int> _availableHours = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
  final List<int> _availableMinutes = [0, 15, 30, 45];
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  String? barberSelected;
  String? serviceSelected;

  _SchedulePageState() {
    dateController.text = DateTime.now().add(const Duration(days: 1)).toString();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Agendar'),
    ),
    body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: barberRecords,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                return DropdownButtonFormField(
                  hint: const Text("Selecione um barbeiro"),
                  isExpanded: true,
                  value: barberSelected,
                  onChanged: (val) => setState(() => barberSelected = val),
                  items: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    final barber = Barber.fromJson(doc.data() as Map<String, dynamic>);

                    return DropdownMenuItem<String>(
                      value: barber.name,
                      child: Text(barber.name),
                    );
                  }).toList()..sort(
                    (e1, e2) => e1.value!.compareTo(e2.value!)
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                  ),
                );
              },
            ),
            const SizedBox(height: 30.0),
            StreamBuilder<QuerySnapshot>(
              stream: serviceRecords,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                return DropdownButtonFormField(
                  hint: const Text("Selecione um serviço"),
                  isExpanded: true,
                  value: serviceSelected,
                  onChanged: (val) => setState(() => serviceSelected = val),
                  items: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    final service = BarberService.fromJson(doc.data() as Map<String, dynamic>);

                    return DropdownMenuItem<String>(
                      value: service.name,
                      child: Text(service.name),
                    );
                  }).toList()..sort(
                    (e1, e2) => e1.value!.compareTo(e2.value!)
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.cut),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                  ),
                );
              },
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMMM, yyyy',
                    controller: dateController,
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 120)),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Data',
                    timeLabelText: "Horas",
                    locale: const Locale('pt', 'BR'),
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      return !(date.weekday == 6 || date.weekday == 7);
                    },
                    onChanged: (val) => setState(() => dateController.text = val),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: timeController,
                    decoration: const InputDecoration(labelText: 'Horas'),
                    showCursor: false,
                    readOnly: true,
                    onTap: () => inputTimeSelect(),
                  ),
                ),
              ]
            ),
            const SizedBox(height: 60.0),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.schedule, size: 32),
              label: const Text(
                'Agendar',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => scheduleAppointment(this.context),
            ),
          ],
        ),
      ),
    ),
  );

  inputTimeSelect() async {
    return await showCustomTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
      },
      onFailValidation: (context) => print("Horário inválido"),
      initialTime: TimeOfDay(
        hour: _availableHours.first,
        minute: _availableMinutes.first
      ),
      selectableTimePredicate: (time) =>
        _availableHours.contains(time!.hour) &&
        _availableMinutes.contains(time.minute),
      ).then(
        (time) => setState(() => timeController.text = time!.format(context))
      );
  }

  void scheduleAppointment(context) async {
    if (
      barberSelected != null &&
      serviceSelected != null &&
      dateController.text.isNotEmpty &&
      timeController.text.isNotEmpty
    ) {
      final docRef = apptCollection.doc();
      final timeSelected = timeController.text.split(':');
      final dateSelected = DateTime.parse(dateController.text);
      final dateTime = DateTime(
        dateSelected.year,
        dateSelected.month,
        dateSelected.day,
        int.parse(timeSelected[0]),
          int.parse(timeSelected[1])
      );

      Appointment newAppointment = Appointment(
        userId: user.uid,
        name: barberSelected!,
        service: serviceSelected!,
        status: serviceName[Service.pending]!,
        time: dateTime,
        id: docRef.id
      );

      docRef.set(newAppointment.toJson()).then(
        (value) => log("Serviço agendado com sucesso!"),
        onError: (e) => log("Erro ao agendar o serviço: $e")
      );

      setState(() {
        barberSelected = null;
        serviceSelected = null;
        dateController.clear();
        timeController.clear();
      });

      log("Serviço agendado com sucesso.");
      _showDialog(
          title: "Pronto!",
          text: "Serviço agendado com sucesso."
      );

    } else {
      log("Por favor, preencha todos os campos.");
      _showDialog(
        title: "Ops!",
        text: "Por favor, preencha todos os campos."
      );
    }
  }

  Future<void> _showDialog({
    required String title,
    required String text,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
        );
      }
    );
  }
}