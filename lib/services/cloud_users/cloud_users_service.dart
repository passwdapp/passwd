import 'package:tuple/tuple.dart';

abstract class CloudUsersService {
  Future<void> ping(
    String secretKey,
    Uri endpoint,
  );

  Future<bool> register(
    String username,
    String password,
    String secretKey,
    Uri endpoint,
  );

  Future<Tuple3<bool, String, String>> login(
    String username,
    String password,
    String secretKey,
    Uri endpoint,
  );
}
