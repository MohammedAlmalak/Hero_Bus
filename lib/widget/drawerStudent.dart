import 'package:flutter/material.dart';

class DrawerStudent extends StatelessWidget {
  final String email;
  final String name;

  const DrawerStudent({Key key, this.email, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo[700]),
            accountEmail: Text(
              '$name',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            accountName: Text('$email',
                style: TextStyle(color: Colors.white, fontSize: 17)),
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
                      'Profile',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/editProfile_Student');
                    },
                    leading: Icon(Icons.account_box_outlined),
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
                      /*  SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.remove('Token'); */
                      Navigator.of(context).pushReplacementNamed('/Login');
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
