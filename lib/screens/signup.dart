/* import 'package:app01/main.dart';
import 'package:app01/widget/progressDialog.dart'; */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Signup extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      appBar: AppBar(
        backgroundColor: Colors.indigo[400],
        title: Text('Student Sign Up'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Create new account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                      ),
                    ),
                    buildCardTextFiled('Name', 'Enter Your Name', iconName,
                        false, nameController),
                    SizedBox(height: 15),
                    buildCardTextFiled('Email', 'Enter Your Email', iconEmail,
                        false, emailController),
                    SizedBox(height: 15),
                    buildCardTextFiled('Password', 'Enter Your Password',
                        iconPass, true, passController),
                    SizedBox(height: 35),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      splashColor: Colors.indigo[400],
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                      onPressed: () {
                        if (nameController.text.length < 4) {
                          displayTostMsg(
                              'The Name must be 4 character', context);
                        } else if (!emailController.text.contains('@')) {
                          displayTostMsg('Email address is not valid', context);
                        } else if (passController.text.length < 6) {
                          displayTostMsg(
                              'The Password must be atleast 6 charactr',
                              context);
                        } else {
                          //rigisterNewUser(context);
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Already have an Account?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black),
                    ),
                    InkWell(
                      child: Text('Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Icon iconName = Icon(
    Icons.edit,
    color: Colors.grey[900],
  );
  Icon iconEmail = Icon(
    Icons.mail_rounded,
    color: Colors.grey[900],
  );
  var iconPass = Icon(
    Icons.vpn_key_rounded,
    color: Colors.grey[900],
  );
  Container buildCardTextFiled(String labelText, String hintText, Icon icon,
      bool obscure, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      child: Card(
        elevation: 15,
        shadowColor: Colors.black,
        margin: EdgeInsets.all(0),
        child: TextFormField(
          // validator: ,
          controller: controller,
          style: TextStyle(color: Colors.black, fontSize: 18),
          cursorColor: Colors.black,
          obscureText: obscure,
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
  }
/* 
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void rigisterNewUser(BuildContext ctx) async {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDiialog(msg: 'Registering, Please wait...');
        });

    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passController.text)
            .catchError((errMsg) {
      Navigator.pop(ctx);
      displayTostMsg("'Error :'" + errMsg.toString(), ctx);
    }))
        .user;

    if (firebaseUser != null) {
      //save user in database
      Map userDataMap = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "passwoord": passController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);
      displayTostMsg('Your acount has been created', ctx);
      Navigator.pushNamedAndRemoveUntil(ctx, '/StudentApp', (route) => false);
    } else {
      Navigator.pop(ctx);
      //error msg
      displayTostMsg('New user account has not been created', ctx);
    }
  } */

  displayTostMsg(String msg, BuildContext ctx) {
    Fluttertoast.showToast(msg: msg);
  }
}
