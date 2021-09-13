import 'package:attrativenesstest/Models/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class NotesController {
  late DatabaseReference _databaseRef;

  NotesController() {
    _databaseRef = FirebaseDatabase.instance.reference();
  }

  Future<List<dynamic>> getNotes() async {
    List<dynamic> _data = [];

    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('notes')
        .reference()
        .orderByChild('date')
        .once()
        .then((value) {
      if (value.value != null) {
        Map<dynamic, dynamic> records = value.value;
        records.forEach((key1, value1) {
          value1['id'] = key1;
          _data.add(value1);
        });
      }
    });

    return _data;
  }

  Future<void> saveNote(note) async {
    List<dynamic> _data = [];

    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('notes')
        .push()
        .set({
      'message': note,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now())
    });
  }

  Future<void> deleteNote(id) async {
    List<dynamic> _data = [];

    await _databaseRef
        .child('users')
        .child(Utils.profileUser.uid)
        .child('notes')
        .child(id)
        .reference()
        .remove();
  }
}
