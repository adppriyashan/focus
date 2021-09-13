import 'package:attrativenesstest/Models/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AttendanceController {
  late DatabaseReference _databaseRef;

  AttendanceController() {
    _databaseRef = FirebaseDatabase.instance.reference();
  }

  Future<Map<dynamic, dynamic>> checkForStudentExists(String key) async {
    late Map obj = {};
    await _databaseRef
        .child('users')
        .reference()
        .orderByChild('studentid')
        .equalTo(key.toUpperCase())
        .once()
        .then((snapshot) async {
      if (snapshot.value != null) {
        obj = snapshot.value;
      }
    });

    return obj;
  }

  Future<List<dynamic>> getAttendanceByStudent(
      studentkey, String start, String end) async {
    List<dynamic> _data = [];

    DatabaseReference query1 = _databaseRef
        .child('users')
        .child(studentkey)
        .child('attendance')
        .reference();

    late var query2;

    if (start.isNotEmpty && end.isNotEmpty) {
      print('date filtered');
      query2 = query1.orderByChild('date').startAt(start).endAt(end);
    }else{
      query2=query1;
    }

    await query2.once().then((value) {
      if (value.value != null) {
        Map<dynamic, dynamic> records = value.value;
        records.forEach((key1, value1) {
          print(value1);
          _data.add(value1);
        });
      }
    });

    return _data;
  }
}
