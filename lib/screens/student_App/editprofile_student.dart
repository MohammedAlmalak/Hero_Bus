import 'package:flutter/material.dart';

class Editprofile extends StatefulWidget {
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  Map<String, String> control = {
    'name': 'Edit your Name',
    'id': 'Edit your ID',
    'phone': 'Edit your Phone number',
    'school': 'Edit School address',
    'home': 'Edit Home address'
  };

  buildAlert(
      BuildContext context, String title, String hint, String controller) {
    var textcontroller = TextEditingController();

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Container(
        height: 125,
        child: Column(children: [
          TextField(
            controller: textcontroller,
            decoration: InputDecoration(
              hintText: hint,
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          // ignore: deprecated_member_use
          RaisedButton(
              child: Text('ok'),
              onPressed: () {
                setState(() {
                  control.update(controller, (value) => textcontroller.text);
                  Navigator.pop(context);
                });
              }),
        ]),
      ),
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
    //showDialog(context: context, child: alert);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(' Profile'),
          centerTitle: true,
          backgroundColor: Colors.indigo[400],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 115,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.indigo[400],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Moahamad almalak',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Mohamad.malak@hotmail.com',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.indigo[400],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.indigo[400],
                            ),
                            title: Text(
                              'Name',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(control['name']),
                            onTap: () {
                              buildAlert(
                                  context, 'Edit your Name', 'name', 'name');
                            },
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.indigo[400],
                            ),
                            title: Text(
                              'ID',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(control['id']),
                            onTap: () {
                              buildAlert(context, 'Edit your ID', 'ID', 'id');
                            },
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.indigo[400],
                            ),
                            title: Text(
                              'Phone',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(control['phone']),
                            onTap: () {
                              buildAlert(context, 'Edit Phone Number', 'Phone',
                                  'phone');
                            },
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.arrow_back_ios_sharp,
                                color: Colors.indigo[400]),
                            title: Text(
                              'Address School',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(control['school']),
                            onTap: () {
                              buildAlert(context, 'Edit Address School',
                                  'Address School', 'school');
                            },
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.arrow_back_ios_sharp,
                                color: Colors.indigo[400]),
                            title: Text(
                              'Address Home',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(control['home']),
                            onTap: () {
                              buildAlert(context, 'Edit Address Home',
                                  'Address Home', 'home');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.indigo[400],
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    onPressed: () {},
                    child: Text(
                      'Save Change',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
