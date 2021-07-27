import 'package:app01/services/apiService.dart';
import 'package:app01/widget/progressDialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/allUsersData.dart';
import 'models/login_model.dart';

class LoginSevenPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/login7.dart";
  @override
  _LoginSevenPageState createState() => _LoginSevenPageState();
}

class _LoginSevenPageState extends State<LoginSevenPage> {
  bool passvisiable = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Icon iconPass = Icon(
    Icons.lock,
    color: Colors.grey[900],
  );

  LoginRequestModel request;
  GlobalKey<FormState> globalFormKe = new GlobalKey<FormState>();
  final scaffoldKe = GlobalKey<ScaffoldState>();
  bool isApiProsse = false;
  @override
  void initState() {
    super.initState();
    request = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKe,
        backgroundColor: Colors.white,
        body: Form(
          key: globalFormKe,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipper2(),
                    child: Container(
                      child: Column(),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(100, 202, 201, 225),
                          Color.fromARGB(100, 123, 114, 175)
                        ],
                        // [Color(0x22ff3a5a), Color(0x22fe494d)]
                      )),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper3(),
                    child: Container(
                      child: Column(),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors:
                            //[Color(0x44ff3a5a), Color(0x44fe494d)]
                            [
                          Color.fromARGB(100, 202, 201, 225),
                          Color.fromARGB(100, 123, 114, 175)
                        ],
                      )),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper1(),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.bus_alert,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Hero Bus",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.indigo,
                          //Color.fromARGB(100, 1, 19, 39),
                          Color.fromARGB(100, 50, 106, 167),
                          //Color.fromARGB(100, 0, 255, 212)
                        ],
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (input) => request.email = input,
                    controller: emailController,
                    validator: (input) =>
                        !input.contains("@") ? "Email should be valid" : null,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.email,
                            color: Colors.indigo.shade500,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    validator: (input) => input.length < 4
                        ? "the Password should be at least 4 character"
                        : null,
                    onSaved: (input) => request.password = input,
                    controller: passController,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    obscureText: passvisiable,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.lock,
                            color: Colors.indigo.shade500,
                          ),
                        ),
                        suffix: GestureDetector(
                          onTap: () => setState(() {
                            passvisiable = !passvisiable;
                          }),
                          child: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: passvisiable
                                ? Icon(Icons.visibility,
                                    color: Colors.grey.shade600)
                                : Icon(Icons.visibility_off,
                                    color: Colors.grey.shade600),
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.indigo.shade400),
                  child: TextButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      if (validateAndSave()) {
                        setState(() {
                          isApiProsse = true;
                        });
                        if (isApiProsse) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return ProgressDiialog(msg: 'Please wait...');
                              });
                          APIServise apiServis = new APIServise();
                          apiServis.login(request).then((value) {
                            print(request.toJson());
                            Request(
                                email: value.email,
                                password: value.pass,
                                namee: value.name);

                            setState(() {
                              isApiProsse = false;
                            });
                            if (value.token.isNotEmpty) {
                              print(value.token);

                              if (value.token == 'Driver') {
                                saveDataInSharedpref(
                                    token: "${value.token}",
                                    email: "${value.email}",
                                    name: "${value.name}",
                                    id: "${value.id}",
                                    phone: "${value.phone}");
                                displayTostMsg("LogIn Successfull", context);
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/DriverApp', (route) => false);
                              } else if (value.token == 'Parents') {
                                saveDataInSharedpref(
                                    token: "${value.token}",
                                    email: "${value.email}",
                                    name: "${value.name}",
                                    id: "${value.id}",
                                    phone: "${value.phone}");

                                displayTostMsg("LogIn Successfull", context);
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/StudentApp', (route) => false);
                              }
                            } else {
                              displayTostMsg(
                                  "'Error : ${value.error}'", context);
                              Navigator.pop(context);
                            }
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "FORGOT PASSWORD ?",
                  style: TextStyle(
                      color: Colors.indigo.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an Account ? ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                  InkWell(
                    onTap: () async {
                      String url = 'https://herobus.000webhostapp.com/';
                      await canLaunch(url)
                          ? await launch(url)
                          : throw 'Could not launch $url';
                    },
                    child: Text("Sign Up ",
                        style: TextStyle(
                            color: Colors.indigo.shade400,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  displayTostMsg(String msg, BuildContext ctx) {
    Fluttertoast.showToast(msg: msg);
  }

  bool validateAndSave() {
    final form = globalFormKe.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  saveDataInSharedpref(
      {String token,
      String email,
      String name,
      String id,
      String phone}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
    pref.setString('email', email);
    pref.setString('name', name);
    pref.setString('id', id);
    pref.setString('phone', phone);
    print("Preeeeef  " + pref.getString('id'));
  }

  chekLoginApi() {
    if (validateAndSave()) {
      setState(() {
        isApiProsse = true;
      });
      if (isApiProsse) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return ProgressDiialog(msg: 'Authenticating, Please wait...');
            });

        APIServise apiServise = new APIServise();
        apiServise.login(request).then((value) {
          //print(requestModel.toJson());
          Request(email: value.email, password: value.pass, namee: value.name);

          setState(() {
            isApiProsse = false;
          });
          if (value.token.isNotEmpty) {
            print(value.token);

            if (value.token == 'Driver') {
              saveDataInSharedpref(
                  email: "${value.email}",
                  name: "${value.name}",
                  id: "${value.id}",
                  phone: "${value.phone}");
              displayTostMsg("LogIn Successfull", context);
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/DriverApp', (route) => false);
            } else if (value.token == 'Parents') {
              saveDataInSharedpref(
                  email: "${value.email}",
                  name: "${value.name}",
                  id: "${value.id}",
                  phone: "${value.phone}");

              displayTostMsg("LogIn Successfull", context);
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/StudentApp', (route) => false);
            }
          } else {
            displayTostMsg("'Error : ${value.error}'", context);
            Navigator.pop(context);
          }
        });
      }
    }
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
