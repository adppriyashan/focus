import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AttentivenessAnalysis extends StatefulWidget {
  AttentivenessAnalysis({Key? key}) : super(key: key);

  @override
  _AttentivenessAnalysisState createState() => _AttentivenessAnalysisState();
}

class _AttentivenessAnalysisState extends State<AttentivenessAnalysis> {
  double fieldspacesmid = 20.0;

  late List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  late bool animate = true;

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            UtilStrings.attentivenessAnalysisTitle,
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
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: Utils.getDefaultTextInputDecoration(
                              'Students',
                              Icon(Icons.arrow_drop_down,
                                  color:
                                      UtilColors.greyColor.withOpacity(0.6))),
                          cursorColor: UtilColors.primaryColor,
                          keyboardType: TextInputType.datetime,
                          initialValue: 'All',
                          style: Utils.getprimaryFieldTextStyle(
                              UtilColors.blackColor),
                          validator: (value) {},
                        ),
                        SizedBox(
                          height: fieldspacesmid,
                        ),
                        TextFormField(
                          decoration: Utils.getDefaultTextInputDecoration(
                              'IT Number',
                              Icon(Icons.code,
                                  color:
                                      UtilColors.greyColor.withOpacity(0.6))),
                          cursorColor: UtilColors.primaryColor,
                          keyboardType: TextInputType.datetime,
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
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: UtilColors.secondaryColor,
                                  side: BorderSide(
                                      color: UtilColors.whiteColor, width: 1),
                                  primary: UtilColors.whiteColor),
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(color: UtilColors.whiteColor),
                              )),
                          width: Utils.displaySize.width,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: new charts.TimeSeriesChart(
                    seriesList,
                    animate: animate,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
