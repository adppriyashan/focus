import 'package:attrativenesstest/Controllers/Auth/AuthController.dart';

class SplashScreenController {
  Future<bool> checkAuth() async {
    return await AuthController().checkAuth();
  }
}
