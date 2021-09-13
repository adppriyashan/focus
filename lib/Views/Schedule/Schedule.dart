import 'package:attrativenesstest/Controllers/ScheduleController.dart';
import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {
  Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  double fieldspacesmid = 20.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            UtilStrings.scheduleTitle,
            style: GoogleFonts.roboto(color: UtilColors.whiteColor),
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          height: Utils.displaySize.height,
          width: Utils.displaySize.width,
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
          child: FutureBuilder<List<dynamic>>(
              future: ScheduleController().getSchedules(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.length > 0) {
                    return ListView(
                        children: snapshot.data!
                            .map((schedule) => ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.timeline,
                                        color: UtilColors.primaryColor,
                                      )
                                    ],
                                  ),
                                  title: Text(schedule['title'].toString()),
                                  subtitle: Text(schedule['start'] +
                                      ' to ' +
                                      schedule['end']),
                                ))
                            .toList());
                  } else {
                    return Center(
                      child: Text('No records Found.'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
