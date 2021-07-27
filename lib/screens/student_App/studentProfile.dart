import 'package:app01/forMe/models/parentChiled_model.dart';
import 'package:app01/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  APIServise api;
  String name;
  String email;
  String phone;
  String homeLoc;
  List<ChildInfo> childInfo;
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  getIdFromShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('name');
      email = pref.getString('email');
      phone = pref.getString('phone');
      homeLoc = pref.getString('homeLocation');
    });
  }

  @override
  void initState() {
    getIdFromShared();
    super.initState();
    //api = new APIServise();
  }

  Future<List<ChildInfo>> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var map = {
      'id': pref.getString('id'),
    };
    api = new APIServise();
    return api.fetchChildInfo(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.indigo[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.indigo[700],
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                          radius: 50,
                        ),
                        Positioned(
                          bottom: 3,
                          right: 2,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 15,
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('$name',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox(height: 5),
                    Text('$email',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "User Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Card(
              margin: EdgeInsets.only(left: 3),
              elevation: 5,
              shadowColor: Color(0xfff29a94),
              child: Container(
                child: Column(
                  children: [
                    buildListTileProfile(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          deleteDataFromSharedpref();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        },
                        title: Text('LogOut'),
                        leading: Icon(Icons.logout, color: secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtomCheatChild(BuildContext context, var op, int i) {
    final primary = Color(0xff696b9e);
    final secondary = Color(0xfff29a94);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[200],
      ),
      width: double.infinity,
      //height: 110,
      /*  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), */
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 10, top: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: secondary),
              image: DecorationImage(
                  image: AssetImage('assets/images/avatar.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    '${op[i].name}',
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text('${op[i].homeAdd}',
                          style: TextStyle(
                              color: primary, fontSize: 15, letterSpacing: .3)),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.school,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text('${op[i].schoolAdd}',
                          style: TextStyle(
                              color: primary, fontSize: 15, letterSpacing: .3)),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.drive_eta,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text('${op[i].driverName}',
                          style: TextStyle(
                              color: primary, fontSize: 15, letterSpacing: .3)),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text('${op[i].driverPhone}',
                          style: TextStyle(
                              color: primary, fontSize: 15, letterSpacing: .3)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showDialogChild(var op, int i) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 10,
            backgroundColor: Colors.indigo[600],
            child: Container(
              margin: EdgeInsets.all(7),
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  //color: Color(0xfff0f0f0),
                  //height: 300.0,
                  child: buildButtomCheatChild(context, op, i),
                ),
              ),
            ),
          );
        });
    /*   showModalBottomSheet(
        backgroundColor: Color(0xfff0f0f0),
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: new Container(
              //color: Color(0xfff0f0f0),
              height: 250.0,
              child: buildButtomCheatChild(context, op, i),
            ),
          );
        }); */
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

  Widget buildChildListTile(var op, int i) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[300],
          ),
        ),
      ),
      child: ListTile(
        onTap: () {
          showDialogChild(op, i);
        },
        title: Text('${op[i].name}',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.indigo[600],
            )),
        leading: Icon(
          Icons.person_pin,
          color: secondary,
        ),
      ),
    );
  }

  buildListTileProfile() {
    return Column(
      children: [
        ListTile(
          title: Text('Name'),
          subtitle: Text('$name',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo)),
          leading: Icon(Icons.account_circle, color: secondary),
        ),
        Divider(height: 0.1, thickness: 0.8),
        //
        ExpansionTile(
          title: Text(
            'My Child',
            style: TextStyle(color: Colors.black),
            // textAlign: TextAlign.center,
          ),
          leading: Icon(Icons.group, color: secondary),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 117,
              child: FutureBuilder(
                future: getData(),
                builder: (ctx, snapshot) => snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return buildChildListTile(snapshot.data, i);
                        })
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xfff29a94)),
                        ),
                      ),
              ),
            ),
          ],
        ),
        //
        Divider(height: 0.1, thickness: 0.8),

        ListTile(
          title: Text('Email'),
          subtitle: Text('$email',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo)),
          leading: Icon(Icons.email, color: secondary),
        ),
        Divider(height: 0.1, thickness: 0.8),
        ListTile(
          title: Text('Phone'),
          subtitle: Text('$phone',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo)),
          leading: Icon(Icons.phone, color: secondary),
        ),
        Divider(height: 0.1, thickness: 0.8),
        ListTile(
          title: Text('Home Location'),
          subtitle: Text("${homeLoc ?? 'Set Addres from Map Screen'} ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo)),
          leading: Icon(Icons.home, color: secondary),
        ),
        Divider(height: 0.1, thickness: 0.8),
      ],
    );
  }
}
/* ExpansionTile(
                      title: Text(
                        'My Child',
                        style: TextStyle(color: Colors.black),
                        // textAlign: TextAlign.center,
                      ),
                      leading: Icon(Icons.group, color: secondary),
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 117,
                          child: FutureBuilder(
                            future: getData(),
                            builder: (ctx, snapshot) => snapshot.hasData
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, i) {
                                      return buildChildListTile(
                                          snapshot.data, i);
                                    })
                                : Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xfff29a94)),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ), */
