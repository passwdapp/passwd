import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:base_x/base_x.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../constants/config.dart';
import 'password_service.dart';

/// [PasswordImpl] implements the [PasswordService] to expose password generation and RNG operations
@LazySingleton(as: PasswordService)
class PasswordImpl implements PasswordService {
  @override
  Future<String> generateDicewarePassword({
    int words = 5,
    bool capitalize = true,
  }) async {
    List<dynamic> dicewareList =
        jsonDecode(await rootBundle.loadString('assets/data/diceware.json'));

    final password = [];
    final max = dicewareList.length;

    for (var i = 0; i < words; i++) {
      final entry = dicewareList[getPsuedoRandomNumber(max)].toString();

      if (capitalize) {
        password.add(entry[0].toUpperCase() + entry.substring(1));
      } else {
        password.add(entry);
      }
    }

    return password.join(' ');
  }

  @override
  int getPsuedoRandomNumber(int max) {
    return Random.secure().nextInt(max);
  }

  @override
  String generateRandomPassword({int length = 12}) {
    final base = BaseXCodec(passwordLetters);

    return base
        .encode(
          Uint8List.fromList(
            List<int>.generate(
              length,
              (index) => getPsuedoRandomNumber(4096),
            ),
          ),
        )
        .split('')
        .sublist(0, length)
        .join('');
  }
}
