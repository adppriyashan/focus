import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Utils.dart';

class PopUpLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PopUpLoadingState();
}

class PopUpLoadingState extends State<PopUpLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      UtilColors.primaryColor),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: Utils.displaySize.width * 0.6,
                  child: Text(
                    (Utils.loadingMessage == null)
                        ? "Please Wait"
                        : Utils.loadingMessage.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        color: UtilColors.whiteColor, fontSize: 12.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
