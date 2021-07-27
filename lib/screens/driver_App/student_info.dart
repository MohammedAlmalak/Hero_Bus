import 'package:app01/services/apiService.dart';
import 'package:app01/forMe/models/studentinfo_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDatel extends StatefulWidget {
  @override
  _StudentDatelState createState() => _StudentDatelState();
}

class _StudentDatelState extends State<StudentDatel> {
  APIServise api;
  String id;
  @override
  void initState() {
    super.initState();
    api = new APIServise();
    //getIdFromShared();
  }

  getIdFromShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString('id');
    });
  }

  Future<List<StudentsInfo>> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var map = {
      'id': pref.getString('id'), //id,
    };
    return api.fetchStudentInfo(map);
  }

  List<StudentsInfo> studentList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Student Information'),
          centerTitle: true,
          backgroundColor: Colors.indigo[400],
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (ctx, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, i) => Container(
                    height: 210.0,
                    child: buildStudentInfo(i: i, op: snapshot.data),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget buildStudentInfo({var op, int i}) {
    final primary = Color(0xff696b9e);
    final secondary = Color(0xfff29a94);
    return SingleChildScrollView(
      //test
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        //width: double.infinity,
        //height: 100,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 15, top: 20),
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
                                color: primary,
                                fontSize: 15,
                                letterSpacing: .3)),
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
                                color: primary,
                                fontSize: 15,
                                letterSpacing: .3)),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.outlet_outlined,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text('${op[i].age}',
                            style: TextStyle(
                                color: primary,
                                fontSize: 15,
                                letterSpacing: .3)),
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
                        child: Text('${op[i].phone}',
                            style: TextStyle(
                                color: primary,
                                fontSize: 15,
                                letterSpacing: .3)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  /*  */
//buildcardStudent(i)),
  /* Stack(
                                      children: [
                                        Card(
                                          elevation: 3,
                                          child: Container(
                                            child: Column(
                                              //crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    'Name',
                                                    style: TextStyle(
                                                        fontSize: 15, color: Colors.grey),
                                                  ),
                                                  subtitle: Text(
                                                    snapshot.data[i].name,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.indigo),
                                                  ),
                                                  // leading: Icon(Icons.account_circle),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    'Phone',
                                                    style: TextStyle(
                                                        fontSize: 15, color: Colors.grey),
                                                  ),
                                                  subtitle: Text(
                                                    snapshot.data[i].phone,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.indigo),
                                                  ),
                                                  // leading: Icon(Icons.phone),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    'School Location',
                                                    style: TextStyle(
                                                        fontSize: 15, color: Colors.grey),
                                                  ),
                                                  subtitle: Text(
                                                    snapshot.data[i].schoolAdd,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.indigo),
                                                  ),
                                                  // leading: Icon(Icons.school_rounded),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    'Home Location',
                                                    style: TextStyle(
                                                        fontSize: 15, color: Colors.grey),
                                                  ),
                                                  subtitle: Text(
                                                    "${snapshot.data[i].homeAdd == '' ? 'Unkown yet' : snapshot.data[i].homeAdd}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.indigo),
                                                  ),
                                                  //leading: Icon(Icons.home),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 50,
                                          top: 65,
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundImage:
                                                AssetImage('assets/images/avatar.png'),
                                          ),
                                        ),
                                      ],
                                    ), */
  /* Container buildcardStudent(int i) {
    return Container(
      width: double.infinity,
      height: 130,
      child: Card(
        child: Row(
          children: [
            // student[i].image,
            SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${student[i].name}'),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Home'),
                        InkWell(
                          child: Icon(
                            Icons.home,
                            size: 30,
                            color: Colors.red,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text('School'),
                        InkWell(
                          child: Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.red,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text('Phone'),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.phone,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } */
}
/* ListView(
          children: [
            buildcardStudent(),
            buildcardStudent(),
            buildcardStudent(),
            buildcardStudent(),
            buildcardStudent(),
            buildcardStudent(),
            buildcardStudent(),
            buildcardStudent(),
          ],
        ),*/
