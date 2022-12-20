import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uncle_sam/models/appointment_model.dart';
import 'package:uncle_sam/widget/schedule_card.dart';

Future<void> _updateAppointmentStatus(appt, status) {
  return apptCollection.doc(appt.id)
    .update({'status': status})
    .then((value) =>  log("Serviço cancelado com sucesso!"))
    .catchError((e) => log("Erro ao cancelar o serviço: $e"));
}

void cancelAppointment(appt) {
  _updateAppointmentStatus(appt, serviceName[Service.canceled]);
}

class UserScheduleCard extends StatelessWidget {
  final Appointment appointment;
  const UserScheduleCard(this.appointment, {super.key});

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: appointment.status == serviceName[Service.pending] ?
        Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => cancelAppointment(appointment),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.cancel,
                label: 'Cancelar',
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)
                ),
              ),
            ],
          ),
          child: ScheduleCard(appointment)
      ) : ScheduleCard(appointment)
  );
}