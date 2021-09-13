import 'package:attrativenesstest/Models/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class QuizController {
  late DatabaseReference _databaseRef;

  QuizController() {
    _databaseRef = FirebaseDatabase.instance.reference();
  }

  Future<List<dynamic>> getQuiz() async {
    List<dynamic> _data = [];

    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('quizes')
        .reference()
        .orderByChild('date')
        .once()
        .then((value) {
      if (value.value != null) {
        Map<dynamic, dynamic> records = value.value;
        records.forEach((key1, value1) {
          _data.add(value1);
        });
      }
    });

    return _data;
  }
}
