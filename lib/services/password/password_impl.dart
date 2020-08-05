import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:passwd/services/password/password_service.dart';

@LazySingleton(as: PasswordService)
class PasswordImpl implements PasswordService {
  @override
  Future<String> generateDicewarePassword({
    int words = 5,
    bool capitalize = true,
  }) async {
    List<dynamic> dicewareList =
        jsonDecode(await rootBundle.loadString("assets/data/diceware.json"));

    List<String> password = [];
    int max = dicewareList.length;

    for (int i = 0; i <= words; i++) {
      String entry = dicewareList[getPsuedoRandomNumber(max)].toString();

      if (capitalize) {
        password.add(entry[0].toUpperCase() + entry.substring(1));
      } else {
        password.add(entry);
      }
    }

    return password.join(" ");
  }

  @override
  int getPsuedoRandomNumber(int max) {
    return Random.secure().nextInt(max);
  }
}
