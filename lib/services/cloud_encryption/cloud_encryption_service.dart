import 'dart:typed_data';

import '../../models/entries.dart';

abstract class CloudEncryptionService {
  Future<Uint8List> encrypt(Entries entries);
  Future<Entries> decrypt(Uint8List entries);
}
