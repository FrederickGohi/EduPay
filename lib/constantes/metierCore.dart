import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'dart:async';

//import 'package:flutter/services.dart';

class Validator {
  static bool phone(String txt) {
    RegExp regExp = RegExp(r"^[0-9]{10}$");
    return regExp.hasMatch(txt);
  }

  static bool email(String txt) {
    return EmailValidator.validate(txt);
  }

  static bool name(String txt) {
    return (txt.isNotEmpty); // en realité 3
  }

  static bool password(String txt) {
    return (txt.length >= 4);
  }
}

class random {
  static String generateTransactionId() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy-HH:mm:ss');
    return formatter.format(now);
  }
}