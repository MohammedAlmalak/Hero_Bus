class LoginResponseModel {
  final String token;
  final String error;
  final String email;
  final String pass;
  final String name;
  final String id;
  final String homeAdd;
  final String schoolAdd;
  final String phone;
  final String lat;
  final String lon;
  final String driver;
  final String phoneDriver;
  final String ssn;

  LoginResponseModel(
      {this.email,
      this.pass,
      this.name,
      this.ssn,
      this.token,
      this.error,
      this.id,
      this.homeAdd,
      this.schoolAdd,
      this.phone,
      this.driver,
      this.phoneDriver,
      this.lat,
      this.lon});
  factory LoginResponseModel.fromjson(Map<String, dynamic> json) {
    if (json['error'] != null) {
      return LoginResponseModel(
        error: json['error'] != null ? json['error'] : '',
        token: json['Token'] != null ? json['Token'] : '',
      );
    } else if (json['Token'] == 'Driver') {
      return LoginResponseModel(
        token: json['Token'] != null ? json['Token'] : '',
        email: json['data']['email'] != null ? json['data']['email'] : '',
        id: json['data']['id'] != null ? json['data']['id'] : '',
        pass: json['data']['password'] != null ? json['data']['password'] : '',
        name:
            json['data']['full_name'] != null ? json['data']['full_name'] : '',
        phone: json['data']['phone'] != null ? json['data']['phone'] : '',
        ssn: json['data']['ssn'] != null ? json['data']['ssn'] : '',
      );
    } else {
      return LoginResponseModel(
        token: json['Token'] != null ? json['Token'] : '',
        email: json['data']['email'] != null ? json['data']['email'] : '',
        id: json['data']['id'] != null ? json['data']['id'] : '',
        pass: json['data']['password'] != null ? json['data']['password'] : '',
        name: json['data']['name'] != null ? json['data']['name'] : '',
        phone: json['data']['phone'] != null ? json['data']['phone'] : '',
      );
    }
  }
}

class LoginRequestModel {
  String email;
  String password;
  LoginRequestModel({
    this.email,
    this.password,
  });
  Map<String, dynamic> toJson() {
    var map = {
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
