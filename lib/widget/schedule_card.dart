import 'package:flutter/material.dart';
import 'package:uncle_sam/models/appointment_model.dart';
import 'package:uncle_sam/utils/utils.dart';

class ScheduleCard extends StatelessWidget {
  final Appointment appointment;
  Color cardColor = Colors.white;

  ScheduleCard(this.appointment, {super.key}) {
    if (appointment.status == serviceName[Service.canceled]) {
      cardColor = Colors.red;
    }
    else if (appointment.status == serviceName[Service.done]) {
      cardColor = Colors.lightGreen;
    }
  }

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.zero,
            child: Stack(
              children: [
                Container(
                  width: 5.0,
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 10.0, left: 15.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.service,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appointment.name),
                              const SizedBox(height: 4.0),
                              Text(
                                appointment.status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: cardColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(Utils.checkDate(appointment.time)),
                              const SizedBox(height: 4.0),
                              Text(Utils.getTime(appointment.time)),
                            ],
                          )
                        ]
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]
    )
  );
}
