import 'package:flutter_test/flutter_test.dart';
import 'package:passwd/services/crypto/crypto_crypt.dart';
import 'package:passwd/services/crypto/crypto_service.dart';

void main() {
  group('CryptoService Test -', () {
    group('CryptoCrypt Test -', () {
      test(
        'Test the SHA512 generation',
        () {
          CryptoService service = CryptoCrypt();

          final testString = 'hello world';
          final actualSha512 =
              '309ecc489c12d6eb4cc40f50c902f2b4d0ed77ee511a7c7a9bcd3ca86d4cd86f989dd35bc5ff499670da34255b45b0cfd830e81f605dcf7dc5542e93ae9cd76f';
          final computedSha512 = service.sha512(testString);

          expect(computedSha512, actualSha512);
        },
      );
    });
  });
}
