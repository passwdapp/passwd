import 'dart:typed_data';

import '../../models/entries.dart';

abstract class CloudEncryptionService {
  Future<Uint8List> encrypt(
    Entries entries,
    String username,
    String password,
  );

  Future<Entries> decrypt(
    Uint8List entries,
    String username,
    String password,
  );
}
