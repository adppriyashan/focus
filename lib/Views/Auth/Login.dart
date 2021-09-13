import 'package:attrativenesstest/Controllers/Auth/AuthController.dart';
import 'package:attrativenesstest/Views/Home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attrativenesstest/Controllers/Auth/AuthValidator.dart';
import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Images.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:attrativenesstest/Views/Auth/RecoverPassword.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  var _loginFormKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _obscurePassword = true;

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
    double fontsize = 12;

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
                      Container(
                        padding: EdgeInsets.only(bottom: spaceAround),
                        width: Utils.displaySize.width * 0.35,
                        child: SizedBox(
                          height: Utils.displaySize.width * 0.35,
                          width: Utils.displaySize.width * 0.35,
                          child: SvgPicture.asset(
                            UtilImages.logoWhiteSVG,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: spaceAround, vertical: spaceAround),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Form(
                                key: _loginFormKey,
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
                                          Text(
                                              UtilStrings.appTitleSection2
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 23.0,
                                                  color: UtilColors
                                                      .secondaryColor))
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, bottom: 10.0),
                                        child: Text(
                                          UtilStrings.loginSubTitle
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
                                              'Email',
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
                                      height: fieldspacesmid,
                                    ),
                                    TextFormField(
                                      controller: _password,
                                      decoration:
                                          Utils.getDefaultTextInputDecoration(
                                              'Password',
                                              Icon(Icons.lock,
                                                  color: UtilColors.greyColor
                                                      .withOpacity(0.6))),
                                      cursorColor: UtilColors.primaryColor,
                                      obscureText: _obscurePassword,
                                      keyboardType: TextInputType.emailAddress,
                                      style: Utils.getprimaryFieldTextStyle(
                                          UtilColors.blackColor),
                                      validator: (value) {
                                        return AuthValidator.validatePassword(
                                            value!);
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _obscurePassword = true;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: fieldspaces,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Checkbox(
                                            value: _rememberMe,
                                            onChanged: (val) {
                                              setState(() {
                                                this._rememberMe = val!;
                                              });
                                            },
                                            activeColor:
                                                UtilColors.primaryColor,
                                            focusColor: Colors.red,
                                            checkColor: UtilColors.whiteColor,
                                            hoverColor: Colors.red,
                                            tristate: false,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                this._rememberMe =
                                                    !this._rememberMe;
                                              });
                                            },
                                            child: Text(
                                              'Remember my credentials',
                                              style:
                                                  TextStyle(fontSize: fontsize),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: fieldspaces,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            child: TextButton(
                                                child: Text(
                                                  "LET'S START",
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty
                                                          .all<Color>(UtilColors
                                                              .whiteColor),
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .all<Color>(UtilColors
                                                              .primaryColor),
                                                ),
                                                onPressed: () async {
                                                  if (_loginFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Utils.showLoader(context);

                                                    try {
                                                      await _authController
                                                          .doLogin({
                                                        'email': _email.text,
                                                        'password':
                                                            _password.text
                                                      }).then((value) {
                                                        if (value == true) {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      Home()));
                                                        }
                                                      });
                                                    } catch (e) {
                                                      Utils.hideLoaderCurrrent(
                                                          context);
                                                    }
                                                  }
                                                })),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        RecoverPassword())),
                                            child: Text(
                                              'Recover Forget Password',
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: spaceAround,
                                    ),
                                    SizedBox(
                                      child: TextButton(
                                          onPressed: () async {
                                            await _authController
                                                .signInWithGoogle()
                                                .then((value) => (value == null)
                                                    ? Utils.showToast(
                                                        'Invalid credentials.')
                                                    : Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                Home())));
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  UtilColors.whiteColorLight,
                                              side: BorderSide(
                                                  color:
                                                      UtilColors.primaryColor,
                                                  width: 1),
                                              primary:
                                                  UtilColors.primaryColorLight),
                                          child: Text(
                                            "START WITH GOOGLE",
                                            style: TextStyle(
                                                color: UtilColors.primaryColor),
                                          )),
                                      width: Utils.displaySize.width,
                                    ),
                                    SizedBox(
                                      height: fieldspaces,
                                    ),
                                    // Align(
                                    //   alignment: Alignment.topCenter,
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (_) => Register()));
                                    //     },
                                    //     child: Text(
                                    //       'No account yet, register today !',
                                    //       style: TextStyle(fontSize: fontsize),
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: fieldspaces,
                                    // ),
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
