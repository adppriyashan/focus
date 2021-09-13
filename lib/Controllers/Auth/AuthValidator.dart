import 'package:email_validator/email_validator.dart';

class AuthValidator {
  static dynamic validateUsername(String value) {
    if (value.isNotEmpty) {
      if (!EmailValidator.validate(value)) {
        return 'Please check your username.';
      } else {
        return null;
      }
    } else {
      return 'Please fill username';
    }
  }

  static dynamic validatePassword(String value) {
    if (value.isNotEmpty) {
      if (value.length < 8) {
        return 'Invalid password (Min : 8 Characters)';
      } else {
        return null;
      }
    } else {
      return 'Please fill password';
    }
  }

  static dynamic validateName(String value) {
    if (value.isNotEmpty) {
      if (value.length < 2) {
        return 'Invalid name (Min : 2 Characters)';
      } else {
        return null;
      }
    } else {
      return 'Please fill name';
    }
  }

  static dynamic validateMobile(String value) {
    if (value.isNotEmpty) {
      if (value.length != 10) {
        return 'Invalid Mobile Number';
      } else {
        return null;
      }
    } else {
      return 'Please fill name';
    }
  }

  static dynamic validateRetypePassword(String password, String value) {
    if (value.isNotEmpty) {
      if (value.length < 8) {
        return 'Invalid retype password (Min : 8 Characters)';
      } else {
        if (password != value) {
          return 'Mismatching passwords, Please recheck';
        } else {
          return null;
        }
      }
    } else {
      return 'Please fill same password';
    }
  }
}
