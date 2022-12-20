import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.redAccent);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static bool isToday(DateTime date) {
    DateTime now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final checkDate = DateTime(date.year, date.month, date.day);

    return (checkDate == today);
  }

  static bool isTomorrow(DateTime date) {
    DateTime now = DateTime.now();

    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final checkDate = DateTime(date.year, date.month, date.day);

    return (checkDate == tomorrow);
  }

  static String checkDate(DateTime date) {
    if (isToday(date)) {
      return "Hoje";
    }

    if (isTomorrow(date)) {
      return "Amanhã";
    }

    return getDate(date);
  }

  static String getTime(date) {
    return DateFormat("HH:mm").format(date);
  }

  static String getDate(date) {
    return DateFormat.yMMMd('pt_BR') .format(date);
  }
}