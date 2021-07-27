//import 'package:app01/forMe/testDrawer.dart';
import 'package:app01/screens/Driver_App/driver_map.dart';

import 'package:app01/services/geolocater_servis.dart';
//import 'package:app01/widget/drawerDriver.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverApp extends StatefulWidget {
  @override
  _DriverAppState createState() => _DriverAppState();
}

class _DriverAppState extends State<DriverApp> {
  final geoDService = GeolocatorService();

  String drawerEmail;
  String drawerId;
  String drawerName;
//

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

//

  @override
  void initState() {
    super.initState();
    getDataFromPrefrences();
  }

  getDataFromPrefrences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      drawerEmail = pref.getString('email');
      drawerId = pref.getString('id');
      drawerName = pref.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: missing_required_param
      child: FutureProvider(
        create: (context) => geoDService.getInitialLocation(),
        child: Scaffold(
          drawer: _buildDrawer(
            email: drawerEmail,
            name: drawerName,
          ),
          /* DraweDriver(
            email: drawerEmail,
            name: drawerName,
          ), */
          appBar: AppBar(
            title: Text('Driver Screen'),
            centerTitle: true,
            backgroundColor: Colors.indigo[400],
          ),
          body: Consumer<Position>(
            builder: (context, position, widget) {
              return (position != null)
                  ? DriversMap(position)
                  : Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.indigo[600],
                    ));
            },
          ),
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
                      child: _buildRow(
                          Icons.accessibility_new, "Student information"),
                      onTap: () =>
                          Navigator.of(context).pushNamed('/student_info')),
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

/*Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: DriversMap()),
              /*Container(
              margin: EdgeInsets.only(bottom: 110, left: 310),
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: Colors.indigo[400],
                child: Icon(Icons.navigation_outlined),
                onPressed: () {},
              ),
            ),*/
            ],
          ),*/
