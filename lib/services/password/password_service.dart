abstract class PasswordService {
  Future<String> generateDicewarePassword({
    int words = 5,
    bool capitalize = true,
  });
  int getPsuedoRandomNumber(int max);
}
