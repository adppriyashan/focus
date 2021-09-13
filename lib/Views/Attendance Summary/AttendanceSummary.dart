import 'package:attrativenesstest/Controllers/AttendanceController.dart';
import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import "package:collection/collection.dart";
import 'dart:math' show pi;

import 'package:intl/intl.dart';

class AttendanceSummary extends StatefulWidget {
  AttendanceSummary({Key? key}) : super(key: key);

  @override
  _AttendanceSummaryState createState() => _AttendanceSummaryState();
}

class _AttendanceSummaryState extends State<AttendanceSummary> {
  double fieldspacesmid = 20.0;

  late List<charts.Series<dynamic, int>> seriesList;
  late bool animate = true;

  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController _student = TextEditingController();

  late AttendanceController _attendanceController = AttendanceController();

  var _formKey = GlobalKey<FormState>();

  static int present = 0;
  static int absant = 0;

  @override
  void dispose() {
    present = 0;
    absant = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            UtilStrings.attendanceSummaryTitle,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DateTimeField(
                              controller: _startDate,
                              format: format,
                              decoration: Utils.getDefaultTextInputDecoration(
                                  'Start Date',
                                  Icon(Icons.date_range,
                                      color: UtilColors.greyColor
                                          .withOpacity(0.6))),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            ),
                            SizedBox(
                              height: fieldspacesmid,
                            ),
                            DateTimeField(
                              controller: _endDate,
                              format: format,
                              decoration: Utils.getDefaultTextInputDecoration(
                                  'End Date',
                                  Icon(Icons.date_range,
                                      color: UtilColors.greyColor
                                          .withOpacity(0.6))),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            ),
                            SizedBox(
                              height: fieldspacesmid,
                            ),
                            TextFormField(
                              controller: _student,
                              decoration: Utils.getDefaultTextInputDecoration(
                                  'Student',
                                  Icon(Icons.format_list_numbered,
                                      color: UtilColors.greyColor
                                          .withOpacity(0.6))),
                              cursorColor: UtilColors.primaryColor,
                              keyboardType: TextInputType.number,
                              style: Utils.getprimaryFieldTextStyle(
                                  UtilColors.blackColor),
                              validator: (value) {},
                            ),
                            SizedBox(
                              height: fieldspacesmid,
                            ),
                            SizedBox(
                              child: TextButton(
                                  onPressed: () async {
                                    await _attendanceController
                                        .checkForStudentExists(
                                            _student.text.toString())
                                        .then((value) async {
                                      if (value.isNotEmpty) {
                                        Map<dynamic, dynamic> record = value;
                                        await _attendanceController
                                            .getAttendanceByStudent(
                                                record.keys.first,
                                                _startDate.text,
                                                _endDate.text)
                                            .then((recordsValues) {
                                          present = 0;
                                          absant = 0;
                                          recordsValues.forEach((rec) {
                                            if (rec['type'] == 1) {
                                              present++;
                                            } else {
                                              absant++;
                                            }
                                          });

                                          setState(() {
                                            Utils.showToast('Process Complete');
                                          });
                                        });
                                      } else {
                                        Utils.showToast("Invalid Student ID");
                                      }
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          UtilColors.secondaryColor,
                                      side: BorderSide(
                                          color: UtilColors.whiteColor,
                                          width: 1),
                                      primary: UtilColors.whiteColor),
                                  child: Text(
                                    "SUBMIT",
                                    style:
                                        TextStyle(color: UtilColors.whiteColor),
                                  )),
                              width: Utils.displaySize.width,
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              (present > 0 || absant > 0)
                  ? Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: new charts.PieChart(
                          seriesList,
                          animate: animate,
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    int x = (present > 0)
        ? ((present / (present + absant)) * 100).round()
        : present;
    int y =
        (absant > 0) ? ((absant / (present + absant)) * 100).round() : absant;

    final data = [
      new LinearSales('Present', 0, x),
      new LinearSales('Adsent', 1, y),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: UtilStrings.attendanceSummaryTitle,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) => '${row.name}',
      )
    ];
  }
}

class LinearSales {
  final String name;
  final int year;
  final int sales;

  LinearSales(this.name, this.year, this.sales);
}
