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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['t'] = this.type;
    data['i'] = this.issuer;
    data['a'] = this.algorithm;
    data['s'] = this.secret;
    data['ac'] = this.account;
    data['d'] = this.digits;
    data['ti'] = this.timeout;
    return data;
  }
}
