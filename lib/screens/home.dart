import 'dart:ui';

import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Color(0xff374ABE,),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(283048), Color(859398)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 100),
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                    radius: 100,
                    backgroundColor: Colors.white.withOpacity(0),
                  ),
                ),
                Text(
                  'Welcome to Hero Bus',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                // ignore: deprecated_member_use
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50.0,
                      width: 250,
                      margin: EdgeInsets.all(10),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/StudentApp');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(88.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                //Color(0xff374ABE), Color(0xff64B6FF)
                                colors: [Colors.blue, Colors.indigo[800]],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Student",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 23),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use

                    Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/DriverApp');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.indigo[800]],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Driver",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 23),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: deprecated_member_use
/*    RaisedButton(
                elevation: 15,
                splashColor: Colors.indigo[400],
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                onPressed: () {},
                child: Text(
                  'Driver',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
              ), */
// ignore: deprecated_member_use
/*     RaisedButton(
                elevation: 15,
                splashColor: Colors.indigo[400],
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 33),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/StudentApp');
                },
                child: Text(
                  'Student',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
              ), */
