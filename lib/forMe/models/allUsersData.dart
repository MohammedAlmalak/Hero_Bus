class Request {
  static String emai;
  static String pass;
  static String name;
  Request({String email, String password, String namee}) {
    emai = email;
    pass = password;
    name = namee;
  }

  static Map<String, String> map = {
    'email': emai,
    'password': pass,
  };
}
/* Map<String, dynamic> toJson() {
    var map = {
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
 */
