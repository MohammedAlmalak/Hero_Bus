import 'package:app01/screens/student_App/studentApp.dart';

import 'package:app01/screens/driver_App/driverApp.dart';
import 'package:app01/screens/driver_App/student_info.dart';

import 'package:flutter/material.dart';
import 'package:app01/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forMe/introScreen.dart';
import 'forMe/testLogin.dart';
import 'screens/driver_App/edit_profile_driver.dart';
import 'screens/student_App/studentProfile.dart';

void main() async {
  /*  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); */
  runApp(MyApp());
}

/* DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child("users");
 */
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*  LocationServices checkLocationOn = new LocationServices(); */
  var checkPref = "";
  @override
  void initState() {
    super.initState();
    //checkLocationOn.checkLocationServicesInDevice();
    chekPref().then((value) {
      if (value != null) {
        setState(() {
          checkPref = value;
        });
      } else {
        setState(() {
          checkPref = null;
        });
      }
    });
  }

  Future<String> chekPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      routes: {
        '/': (context) => IntroScreen(), // Homepage(),
        '/Login': (context) => LoginSevenPage(), //Login(),
        '/Signup': (context) => Signup(),
        '/DriverApp': (context) => DriverApp(),
        '/editProfile_Student': (context) => StudentProfile(),
        '/StudentApp': (context) => StudentApp(),
        '/student_info': (context) => StudentDatel(),
        '/editProfile_Driver': (context) => Editprofile_driver(),
        '/App': (context) => checkPref == 'Driver'
            ? DriverApp()
            : checkPref == 'Parents'
                ? StudentApp()
                : IntroScreen(),
      },
      initialRoute: '/App',
      debugShowCheckedModeBanner: false,
      // home: Login(),
    );
  }
}
