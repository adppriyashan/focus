import 'package:attrativenesstest/Controllers/Auth/AuthController.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:attrativenesstest/Controllers/Auth/AuthValidator.dart';
import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';

class RecoverPassword extends StatefulWidget {
  RecoverPassword({Key? key}) : super(key: key);

  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  TextEditingController _email = TextEditingController();

  var _formKey = GlobalKey<FormState>();

   late AuthController _authController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(Utils.lightNavbar);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _authController = AuthController();
  }

  @override
  Widget build(BuildContext context) {
    double spaceAround = 10.0;
    double fieldspaces = 15.0;
    double fieldspacesmid = 20.0;

    return SafeArea(
        child: Scaffold(
      backgroundColor: UtilColors.greyColor,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Container(
                  width: Utils.displaySize.width,
                  height: Utils.displaySize.height,
                  decoration: Utils.getGradientBackground(),
                ),
                Container(
                  width: Utils.displaySize.width,
                  height: Utils.displaySize.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: spaceAround, vertical: spaceAround),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: fieldspaces,
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              UtilStrings.appTitleSection1
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 23.0,
                                                  color:
                                                      UtilColors.primaryColor)),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text(
                                                UtilStrings.appTitleSection2
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 23.0,
                                                    color: UtilColors
                                                        .secondaryColor)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, bottom: 10.0),
                                        child: Text(
                                          UtilStrings.forgetPasswordSubTitle
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w600,
                                              foreground: Paint()
                                                ..shader =
                                                    Utils.getTextGradient()),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: fieldspacesmid,
                                    ),
                                    TextFormField(
                                      controller: _email,
                                      decoration:
                                          Utils.getDefaultTextInputDecoration(
                                              'Your Email',
                                              Icon(
                                                Icons.email,
                                                color: UtilColors.greyColor
                                                    .withOpacity(0.6),
                                              )),
                                      cursorColor: UtilColors.primaryColor,
                                      keyboardType: TextInputType.emailAddress,
                                      style: Utils.getprimaryFieldTextStyle(
                                          UtilColors.greyColor),
                                      validator: (value) {
                                        return AuthValidator.validateUsername(
                                            value!);
                                      },
                                    ),
                                    SizedBox(
                                      height: fieldspaces,
                                    ),
                                    SizedBox(
                                      child: TextButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _authController
                                                  .sendRecoverLink(_email.text);
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: UtilColors
                                                  .whiteColorLight,
                                              side: BorderSide(
                                                  color:
                                                      UtilColors.primaryColor,
                                                  width: 1),
                                              shape:
                                                  const BeveledRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                              primary:
                                                  UtilColors.primaryColorLight),
                                          child: Text(
                                            "SEND RECOVER EMAIL.",
                                            style: TextStyle(
                                                color: UtilColors.primaryColor),
                                          )),
                                      width: Utils.displaySize.width,
                                    ),
                                    SizedBox(
                                      height: fieldspaces,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
