import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StudentWiseAnalysis extends StatefulWidget {
  StudentWiseAnalysis({Key? key}) : super(key: key);

  @override
  _StudentWiseAnalysisState createState() => _StudentWiseAnalysisState();
}

class _StudentWiseAnalysisState extends State<StudentWiseAnalysis> {
  double fieldspacesmid = 20.0;

  late List<charts.Series<dynamic, String>> seriesList;
  late bool animate = true;

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            UtilStrings.studentWiseAnalysisTitle,
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
                              'Start Date',
                              Icon(Icons.date_range,
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
                        TextFormField(
                          decoration: Utils.getDefaultTextInputDecoration(
                              'End Date',
                              Icon(Icons.date_range,
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
                  child: charts.BarChart(
                    seriesList,
                    animate: animate,
                    barGroupingType: charts.BarGroupingType.grouped,
                    vertical: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('Jan-01', 5),
      new OrdinalSales('Jan-02', 25),
      new OrdinalSales('Jan-03', 45),
      new OrdinalSales('Jan-04', 28),
      new OrdinalSales('Jan-05', 20),
    ];

    final tableSalesData = [
      new OrdinalSales('Jan-01', 25),
      new OrdinalSales('Jan-02', 50),
      new OrdinalSales('Jan-03', 10),
      new OrdinalSales('Jan-04', 32),
      new OrdinalSales('Jan-05', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData,
          displayName: 'Attractiveness',
          overlaySeries: true,
          seriesCategory: 'Attractiveness'),
      new charts.Series<OrdinalSales, String>(
          id: 'Tablet',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: tableSalesData,
          displayName: 'Performance',
          overlaySeries: true,
          seriesCategory: 'Performance'),
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
