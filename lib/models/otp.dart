class Otp {
  String type = "totp";
  String issuer = "Generic Issuer";
  String algorithm = "SHA1";
  String secret;
  String account;
  int digits = 6;
  int timeout = 30;

  Otp({
    this.issuer,
    this.algorithm,
    this.secret,
    this.account,
    this.digits,
    this.timeout,
  });

  static Map toMap(Otp otp) {
    return {
      "type": otp.type,
      "issuer": otp.issuer,
      "algorithm": otp.algorithm,
      "account": otp.account,
    };
  }
}
