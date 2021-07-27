import 'dart:async';

import 'package:app01/forMe/models/studentinfo_model.dart';
import 'package:app01/services/apiService.dart';
import 'package:app01/services/geolocater_servis.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriversMap extends StatefulWidget {
  final Position initialPositionD;

  DriversMap(this.initialPositionD);

  @override
  _MyMapsState createState() => _MyMapsState();
}

class _MyMapsState extends State<DriversMap> {
  APIServise api;

  GoogleMapController newController;
  final GeolocatorService geoServiceD = GeolocatorService();
  Completer<GoogleMapController> _controller = Completer();
  double paddingOfMap = 0;
  List<Marker> markerStudent = [];
  //String id;
  bool ispress = false;
  double paddingIcon = 0;
  void initState() {
    geoServiceD.getCurrentLocation().listen((position) {
      centerScreenD(position);
      print('My Location ' + '${position.latitude}::${position.longitude}');
    });
    //api = new APIServise();
    super.initState();
  }

  Future<List<StudentsInfo>> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var map = {
      'id': pref.getString('id'),
    };
    api = new APIServise();
    return api.fetchStudentInfo(map);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        markers: Set.from(markerStudent),
        padding: EdgeInsets.only(bottom: paddingOfMap),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        trafficEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        indoorViewEnabled: true,
        mapToolbarEnabled: true,
        scrollGesturesEnabled: true,
        buildingsEnabled: true,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialPositionD.latitude,
              widget.initialPositionD.longitude),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            paddingOfMap = 250;
            newController = controller;
          });
        },
      ),
      Positioned(
        top: (MediaQuery.of(context).size.height / 2.1),
        // ignore: deprecated_member_use
        child: FlatButton(
          height: 50,
          color: Colors.white,
          onPressed: () {
            if (markerStudent != null) {
              setState(() {
                markerStudent = [];
                newController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(widget.initialPositionD.latitude,
                      widget.initialPositionD.longitude),
                  zoom: 17.44,
                  tilt: 30.0,
                  //bearing: 90
                )));
              });
            }
            /* setState(() {
              markerStudent = [];
            }); */
          },
          shape: CircleBorder(),
          child: Icon(
            Icons.location_off_rounded,
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        top: ispress ? paddingIcon : null,
        bottom: ispress ? null : 10,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    ispress = !ispress;
                    paddingIcon = 410;
                  });
                },
                icon: ispress
                    ? Icon(
                        Icons.keyboard_arrow_down,
                        size: 50,
                        color: Colors.pinkAccent.shade400,
                      )
                    : Icon(
                        Icons.keyboard_arrow_up,
                        size: 50,
                        color: Colors.pinkAccent.shade400,
                      ),
              ),
              ispress
                  ? Text('')
                  : Text(
                      'Press to show Student Location',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        backgroundColor: Colors.grey[900],
                      ),
                    ),
            ],
          ),
        ),
      ),
      ispress
          ? Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: FutureBuilder(
                      future: getData(),
                      builder: (ctx, snapshot) => snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, i) => buildRowStudent(
                                op: snapshot.data,
                                i: i,
                              ),
                            )
                          : Center(child: CircularProgressIndicator()) //,
                      ),
                ),
              ),
            )
          : Text(''),
    ]);
  }

  void delMarkerFromMap(Position position) {
    newController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(widget.initialPositionD.latitude,
            widget.initialPositionD.longitude),
        zoom: 17.44,
        tilt: 0.0,
        bearing: 0.0,
      ),
    ));
    setState(() {
      markerStudent = [];
    });
    /*  newController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(widget.initialPositionD.latitude,
            widget.initialPositionD.longitude),
        zoom: 17.44,
        tilt: 0.0,
        bearing: 0.0,
      ),
    ));
    setState(() {
      markerStudent = [];
    }); */
  }

  getstudentLocation(
      {String lat, String lon, String homeAdd, String schoolAdd, String name}) {
    try {
      double latuide = lat != null ? double.parse(lat) : 0;
      double longtuide = lat != null ? double.parse(lon) : 0;
      setState(() {
        markerStudent = [];
        if (latuide != 0 && longtuide != 0) {
          markerStudent.add(
            Marker(
                markerId: MarkerId(name),
                position: LatLng(latuide, longtuide),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                infoWindow: InfoWindow(
                    snippet: schoolAdd ?? homeAdd,
                    title: schoolAdd != null ? 'School' : "Home")),
          );
        }
        newController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(latuide, longtuide),
                zoom: 17.44,
                tilt: 45.0,
                bearing: 90)));
        /*   newController.isMarkerInfoWindowShown(MarkerId(name)).then((value) {
          if (value) {
            newController.hideMarkerInfoWindow(MarkerId(name));
          } else {
            newController.showMarkerInfoWindow(MarkerId(name));
          }
        }); */
      });
    } on Exception catch (_) {
      displayTostMsg(
          "The Parent of child does\'t set Home Location yet", context);
    }
  }

  displayTostMsg(String msg, BuildContext ctx) {
    Fluttertoast.showToast(msg: msg);
  }

  Widget buildRowStudent({
    var op,
    int i,
  }) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 3, color: Color(0xfff29a94)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/avatar.png'),
                      fit: BoxFit.fill),
                ),
              ),
              /* CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
                radius: 30,
              ), */
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      op[i].name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      op[i].phone,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            getstudentLocation(
                                name: op[i].name,
                                homeAdd: op[i].homeAdd,
                                lat: op[i].homeLat,
                                lon: op[i].homeLon);
                          },
                          child:
                              Icon(Icons.home, color: Colors.indigo.shade400)),
                      Text('home',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade400)),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            getstudentLocation(
                                name: op[i].name,
                                schoolAdd: op[i].schoolAdd,
                                lat: op[i].schoolLat,
                                lon: op[i].schoolLon);
                          },
                          child: Icon(Icons.school,
                              color: Colors.indigo.shade400)),
                      Text('School',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade400)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 3),
          Divider(
            color: Colors.black,
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> centerScreenD(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 16)));
  }
}
/* Column(
              children: [
                Text("Student Adress",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                SizedBox(height: 3),
                Divider(
                  color: Colors.black,
                  height: 10,
                ),
              ],
            ), */
/* 
    CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        radius: 23,
                      ),
                      Text(
                        'Mohammed Almalak',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      FlatButton(
                        onPressed: () => {},
                        shape: CircleBorder(),
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: [Icon(Icons.home), Text("home")],
                        ),
                      ),
                      FlatButton(
                        onPressed: () => {},
                        shape: CircleBorder(),
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: [Icon(Icons.home), Text("home")],
                        ),
                      ), */

/* void _onMapCreated(GoogleMapController _cntlr) {
    newController = _cntlr;
    /* _controller.complete(_cntlr);
    newController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: _initialcameraposition,
            // LatLng(_currentPosition.latitude, _currentPosition.longitude),
            zoom: 15),
      ),
    ); */
  } */

/* getLoc() async {
    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    //streamloc =
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      //
      newController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: _initialcameraposition,
              // LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 15),
        ),
      ); 
//
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);
        //
      });
    });
  }*/

/* bool _serviceEnabled;
    PermissionStatus _permissionGranted;

   _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
*/
