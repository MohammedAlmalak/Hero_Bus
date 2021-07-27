import 'package:app01/screens/student_App/map.dart';
import 'package:app01/services/geolocater_servis.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentApp extends StatefulWidget {
  @override
  _StudentAppState createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  final geoService = GeolocatorService();
  String drawerEmail;
  String drawerId;
  String drawerName;

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  getDataFromPrefrences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      drawerEmail = pref.getString('email');
      drawerId = pref.getString('id');
      drawerName = pref.getString('name');
    });
  }

  @override
  void initState() {
    getDataFromPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: missing_required_param
      child: FutureProvider(
        //initialData: null,
        create: (context) => geoService.getInitialLocation(),
        child: Scaffold(
          drawer: _buildDrawer(email: drawerEmail, name: drawerName),
          /* DrawerStudent(
            email: drawerEmail,
            name: drawerName,
          ), */
          appBar: AppBar(
            centerTitle: true,
            title: Text('Parent Screen'),
            backgroundColor: Colors.indigo[700],
          ),
          body: Consumer<Position>(
            builder: (context, position, widget) {
              return (position != null)
                  ? MyMap(position)
                  : Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.indigo[600],
                    ));
            },
          ),

          //MyMaps(),
        ),
      ),
    );
  }

  _buildDrawer({String name, String email}) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.indigo[600]
                        /* gradient: LinearGradient(colors: [
                          Color(0xffb95103B),
                          Colors.indigo.shade300
                        ])*/
                        ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/avatar.png'), ////
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "$name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "$email",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  GestureDetector(
                      child: _buildRow(Icons.home, "Home"),
                      onTap: () => Navigator.pop(context)),
                  _buildDivider(),
                  GestureDetector(
                      child: _buildRow(Icons.accessibility_new, "Profile"),
                      onTap: () => Navigator.of(context)
                          .pushNamed('/editProfile_Student')),
                  _buildDivider(),
                  _buildRow(Icons.notifications, "Notifications"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  GestureDetector(
                    child: _buildRow(Icons.logout, "Logout"),
                    onTap: () {
                      deleteDataFromSharedpref();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                  ),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteDataFromSharedpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('email');
    pref.remove('name');
    pref.remove('id');
    pref.remove('phone');
    pref.remove('token');
    pref.clear();
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 18.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: Colors.indigo.shade500,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        /* if (showBadge)
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ) */
      ]),
    );
  }
}
