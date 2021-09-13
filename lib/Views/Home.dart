import 'package:app_usage/app_usage.dart';
import 'package:attrativenesstest/Controllers/Auth/AuthController.dart';
import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:attrativenesstest/Views/Attendance%20Summary/AttendanceSummary.dart';
import 'package:attrativenesstest/Views/Attentiveness%20Analysis/AttentivenessAnalysis.dart';
import 'package:attrativenesstest/Views/Auth/Login.dart';
import 'package:attrativenesstest/Views/Notes/Notes.dart';
import 'package:attrativenesstest/Views/Quiz%20Results/Quiz.dart';
import 'package:attrativenesstest/Views/Student%20Wise%20Analytics/StudentWiseAnalysis.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Schedule/Schedule.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<AppUsageInfo> _infos;

  @override
  void initState() {
    getUsageStats();
    super.initState();
  }

  void getUsageStats() async {
    try {
      DateTime startDate = DateTime(2021, 08, 31);
      DateTime endDate = new DateTime.now();
      List<AppUsageInfo> infos = await AppUsage.getAppUsage(startDate, endDate);
      this._infos = infos;
      for (AppUsageInfo info in infos) {
        print(info.packageName + ' - ' + info.usage.inMinutes.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            UtilStrings.appTitle,
            style: GoogleFonts.roboto(color: UtilColors.whiteColor),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                child: Icon(Icons.logout),
                onTap: () {
                  AuthController().logout(context);
                },
              ),
            )
          ],
        ),
        drawer: drawer(),
        body: Container(
          height: Utils.displaySize.height,
          width: Utils.displaySize.width,
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dashboard Analytics',
                        style: GoogleFonts.roboto(
                            color: UtilColors.primaryColor, fontSize: 15.0))
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.only(top: 10.0),
                    color: UtilColors.primaryColorLight,
                    child: SfCartesianChart(
                        title: ChartTitle(text: 'Attactiveness Graph'),
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<GraphKeyVal, String>>[
                          LineSeries<GraphKeyVal, String>(
                              dataSource: <GraphKeyVal>[
                                GraphKeyVal('Jan', 35),
                                GraphKeyVal('Feb', 28),
                                GraphKeyVal('Mar', 34),
                                GraphKeyVal('Apr', 32),
                                GraphKeyVal('May', 40)
                              ],
                              xValueMapper: (GraphKeyVal sales, _) => sales.key,
                              yValueMapper: (GraphKeyVal sales, _) => sales.val)
                        ])),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.only(top: 10.0),
                    color: UtilColors.secondaryColorLight,
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<GraphKeyVal, String>>[
                          LineSeries<GraphKeyVal, String>(
                              dataSource: <GraphKeyVal>[
                                GraphKeyVal('Jan', 35),
                                GraphKeyVal('Feb', 28),
                                GraphKeyVal('Mar', 34),
                                GraphKeyVal('Apr', 32),
                                GraphKeyVal('May', 40)
                              ],
                              xValueMapper: (GraphKeyVal sales, _) => sales.key,
                              yValueMapper: (GraphKeyVal sales, _) => sales.val)
                        ])),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.only(top: 10.0),
                    color: UtilColors.redColor,
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<GraphKeyVal, String>>[
                          LineSeries<GraphKeyVal, String>(
                              dataSource: <GraphKeyVal>[
                                GraphKeyVal('Jan', 35),
                                GraphKeyVal('Feb', 28),
                                GraphKeyVal('Mar', 34),
                                GraphKeyVal('Apr', 32),
                                GraphKeyVal('May', 40)
                              ],
                              xValueMapper: (GraphKeyVal sales, _) => sales.key,
                              yValueMapper: (GraphKeyVal sales, _) => sales.val)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: ClipOval(
                          child: Image.network(
                              'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png'),
                        ))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Utils.profileUser.name,
                        style: GoogleFonts.openSans(
                            color: UtilColors.whiteColor, fontSize: 15.0)),
                    Text(Utils.profileUser.email,
                        style: GoogleFonts.openSans(
                            color: UtilColors.whiteColor, fontSize: 12.0))
                  ],
                )
              ],
            ),
          ),
          (Utils.profileUser.type == 1)
              ? ListTile(
                  title: const Text('Attentiveness Analysis'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AttentivenessAnalysis()));
                  },
                  trailing: Icon(Icons.arrow_forward_ios),
                )
              : SizedBox.shrink(),
          (Utils.profileUser.type == 1)
              ? ListTile(
                  title: const Text('Student Wise Analysis'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => StudentWiseAnalysis()));
                  },
                  trailing: Icon(Icons.arrow_forward_ios),
                )
              : SizedBox.shrink(),
          (Utils.profileUser.type == 1)
              ? ListTile(
                  title: const Text('Attendance summary'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => AttendanceSummary()));
                  },
                  trailing: Icon(Icons.arrow_forward_ios),
                )
              : SizedBox.shrink(),
          ListTile(
            title: const Text('Notes'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Notes()));
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text('Schedule'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Schedule()));
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text('Quiz Results'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Quiz()));
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

class GraphKeyVal {
  GraphKeyVal(this.key, this.val);
  final String key;
  final double val;
}
