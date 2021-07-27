import 'package:app01/forMe/models/allUsersData.dart';
import 'package:app01/forMe/models/login_model.dart';

import 'package:app01/services/apiService.dart';
import 'package:app01/widget/progressDialog.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var passvisiable = true;
  //var controllerDS = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Icon iconPass = Icon(
    Icons.lock,
    color: Colors.grey[900],
  );
  Icon iconEmail = Icon(
    Icons.mail_rounded,
    color: Colors.grey[900],
  );

  LoginRequestModel requestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool isApiProsses = false;
  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.indigo[400],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: Form(
              key: globalFormKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                    radius: 100,
                    backgroundColor: Colors.white.withOpacity(0),
                  ),
                  Text(
                    'Hero Bus',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),

                  Container(
                    margin: EdgeInsets.only(right: 15, left: 15),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      margin: EdgeInsets.all(0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => requestModel.email = input,
                        controller: emailController,
                        validator: (input) => !input.contains("@")
                            ? "Email should be valid"
                            : null,
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            labelText: "Email",
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.indigo[900],
                            ),
                            hintText: "Enter your Email",
                            prefixIcon: iconEmail),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(right: 15, left: 15),
                    height: 72,
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      margin: EdgeInsets.all(0),
                      child: TextFormField(
                        validator: (input) => input.length < 4
                            ? "the Password should be at least 4 character"
                            : null,
                        onSaved: (input) => requestModel.password = input,
                        controller: passController,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        obscureText: passvisiable,
                        keyboardType: TextInputType.visiblePassword,
                        //cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.indigo[900],
                          ),
                          hintText: "Enter Your password",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: iconPass,
                          suffix: IconButton(
                            icon: passvisiable
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            color: Colors.indigo[900].withOpacity(0.5),
                            onPressed: () => setState(() {
                              passvisiable = !passvisiable;
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(left: 200),
                    child: InkWell(
                      child: Text('Forget Pasword ?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: 15),
                  // ignore: deprecated_member_use
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 83),
                    onPressed: () {
                      if (validateAndSave()) {
                        setState(() {
                          isApiProsses = true;
                        });
                        if (isApiProsses) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return ProgressDiialog(
                                    msg: 'Authenticating, Please wait...');
                              });

                          APIServise apiServise = new APIServise();
                          apiServise.login(requestModel).then((value) {
                            //print(requestModel.toJson());
                            Request(
                                email: value.email,
                                password: value.pass,
                                namee: value.name);

                            setState(() {
                              isApiProsses = false;
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
                              displayTostMsg(
                                  "'Error : ${value.error}'", context);
                              Navigator.pop(context);
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    color: Colors.white,
                    shape: StadiumBorder(),
                  ),

                  SizedBox(height: 15),
                  Text(
                    "Don't Have an Account?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                      child: Text('Sign Up',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onTap: () async {
                        String url = 'https://herobus.000webhostapp.com/';
                        await canLaunch(url)
                            ? await launch(url)
                            : throw 'Could not launch $url';
                      }

                      //=> selectScreen(context, '/Signup')
                      /*  String url = 'https://pub.dev/packages/url_launcher';
                       await canLaunch(url)
                          ? await launch(url)
                          : throw 'Could not launch $url'; */

                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  displayTostMsg(String msg, BuildContext ctx) {
    Fluttertoast.showToast(msg: msg);
  }

  void selectScreen(BuildContext ctx, String sc) {
    Navigator.of(ctx).pushNamed(sc);
  }

  saveDataInSharedpref(
      {String email, String name, String id, String phone}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', email);
    pref.setString('name', name);
    pref.setString('id', id);
    pref.setString('phone', phone);
    print("Preeeeef  " + pref.getString('id'));
  }
}
// ignore: deprecated_member_use
/*  RaisedButton(
                    splashColor: Colors.indigo[400],
                    color: Colors.white,
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    onPressed: () {
                      if (validateAndSave()) {
                        setState(() {
                          isApiProsses = true;
                        });
                        if (isApiProsses) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return ProgressDiialog(
                                    msg: 'Authenticating, Please wait...');
                              });

                          APIServise apiServise = new APIServise();
                          apiServise.login(requestModel).then((value) {
                            //print(requestModel.toJson());
                            setState(() {
                              isApiProsses = false;
                            });
                            if (value.token.isNotEmpty) {
                              print(value.token);
                              if (value.token == 'Driver') {
                                displayTostMsg("LogIn Successfull", context);
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/DriverApp', (route) => false);
                              } else if (value.token == 'Student') {
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
                  ), */

/* Container buildTextFiledPass(
      String labelText, String hintText, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      height: 72,
      child: Card(
        elevation: 15,
        shadowColor: Colors.black,
        margin: EdgeInsets.all(0),
        child: TextFormField(
        
          controller: controller,
          style: TextStyle(color: Colors.black, fontSize: 20),
          obscureText: passvisiable,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 20,
              color: Colors.indigo[900],
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            prefixIcon: iconPass,
            suffix: IconButton(
              icon: passvisiable
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              color: Colors.grey[900],
              onPressed: () => setState(() {
                passvisiable = !passvisiable;
              }),
            ),
          ),
        ),
      ),
    );
  } */

/*  Container buildTextFieldemail(String labelText, String hintText, Icon icon,
      TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      child: Card(
        elevation: 15,
        shadowColor: Colors.black,
        margin: EdgeInsets.all(0),
        child: TextFormField(
          //
          // onSaved: (input) => requestModel.passworrd = input,
          //
          controller: controller,
          style: TextStyle(color: Colors.black, fontSize: 18),
          cursorColor: Colors.black,
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.indigo[900],
              ),
              hintText: hintText,
              prefixIcon: icon),
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  } */

//
//
/*   if (!emailController.text.contains('@')) {
                        displayTostMsg('Email address is not valid', context);
                      } else if (passController.text.isEmpty) {
                        displayTostMsg('The Password is not correct', context);
                      } else {
                        loginUser(context);
                      } */
/* if (value.token.isNotEmpty) {
                              print(value.token);
                              displayTostMsg("LogIn Successfull", context);
                              Navigator.pop(context);
                              /*  Navigator.pushNamedAndRemoveUntil(
                                  context, '/DriverApp', (route) => false); */
                            } */

/*  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginUser(BuildContext ctx) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDiialog(msg: 'Authenticating, Please wait...');
        });

    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayTostMsg("'Error :'" + errMsg.toString(), ctx);
    }))
        .user;

    if (firebaseUser != null) {
      //save user in database

      userRef.child(firebaseUser.uid).once().then((DataSnapshot snapShot) {
        if (snapShot != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/StudentApp', (route) => false);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayTostMsg('No record for this user', context);
        }
      });
      displayTostMsg('You are Logged-In now', ctx);
    } else {
      //error msg
      Navigator.pop(context);
      displayTostMsg('Can not be sigend in', ctx);
    }
  }
 */
