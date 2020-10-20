/// [Otp] holds information for an OTP associated with an account (used for 2fa)
/// [Otp] is JSON and MsgPack serializable
class Otp {
  String type;
  String issuer;
  String algorithm;
  String secret;
  String account;
  int digits;
  int timeout;

  Otp({
    this.type,
    this.issuer,
    this.algorithm,
    this.secret,
    this.account,
    this.digits = 6,
    this.timeout = 30,
  });

  Otp.fromJson(Map<String, dynamic> json) {
    type = json['t'];
    issuer = json['i'];
    algorithm = json['a'];
    secret = json['s'];
    account = json['ac'];
    digits = json['d'];
    timeout = json['ti'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['t'] = type;
    data['i'] = issuer;
    data['a'] = algorithm;
    data['s'] = secret;
    data['ac'] = account;
    data['d'] = digits;
    data['ti'] = timeout;
    return data;
  }
}
