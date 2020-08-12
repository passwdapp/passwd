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
    this.digits,
    this.timeout,
  });

  Otp.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    issuer = json['issuer'];
    algorithm = json['algorithm'];
    secret = json['secret'];
    account = json['account'];
    digits = json['digits'];
    timeout = json['timeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['issuer'] = this.issuer;
    data['algorithm'] = this.algorithm;
    data['secret'] = this.secret;
    data['account'] = this.account;
    data['digits'] = this.digits;
    data['timeout'] = this.timeout;
    return data;
  }
}
