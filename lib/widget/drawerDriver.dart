import 'package:flutter/material.dart';

class DraweDriver extends StatelessWidget {
  final String email;
  final String name;

  const DraweDriver({Key key, this.email, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo[400]),
            accountEmail: Text(
              '$email',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            accountName: Text('$name',
                style: TextStyle(color: Colors.black, fontSize: 17)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
              radius: 50,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  shadowColor: Colors.indigoAccent,
                  child: ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    leading: Icon(Icons.home_outlined),
                  ),
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.indigoAccent,
                  child: ListTile(
                      title: Text(
                        'Student information',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/student_info');
                      },
                      leading: Icon(Icons.accessibility_new)),
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.indigoAccent,
                  child: ListTile(
                    title: Text(
                      'Request',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {},
                    leading: Icon(Icons.departure_board),
                  ),
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.indigoAccent,
                  child: ListTile(
                    title: Text(
                      'Notification',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {},
                    leading: Icon(Icons.notifications_on_outlined),
                  ),
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.indigoAccent,
                  child: ListTile(
                    title: Text(
                      'Setting',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {},
                    leading: Icon(Icons.settings),
                  ),
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.indigoAccent,
                  child: ListTile(
                    title: Text(
                      'Contact Us',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {},
                    leading: Icon(Icons.contact_support_outlined),
                  ),
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.indigoAccent,
                  child: ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      /*   SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.remove('Token'); */
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/Login', (route) => false);
                    },
                    leading: Icon(Icons.logout),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
