import 'dart:async';
import 'dart:convert';

//import 'package:app01/forMe/mapKey.dart';
import 'package:app01/services/geolocater_servis.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart'; // as geocoder;
//import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMap extends StatefulWidget {
  final Position initialPosition;

  MyMap(this.initialPosition);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MyMap> {
  //var homeLocation;
  final GeolocatorService geoService = GeolocatorService();
  Completer<GoogleMapController> _controller = Completer();
  //
  GoogleMapController newGoogleMapController;
  //
  List<LatLng> latlong = [];
  Set<Polyline> polyline = {};
  double latude;
  double longtude;
  //Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<Marker> mymarker = [];
  Position currentPosition;
  var adr;
  var contury;
  var subLocality;
  double paddingOfMap = 0;
  bool isEdit = false;
  bool ispress = false;
  double paddingIcon = 0;

  String homeLocation;
  @override
  void initState() {
    geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
      setState(() {
        currentPosition = position;
        print('My Location ' + '${position.latitude}::${position.longitude}');
      });
    });
    getDataFromPrefrences();
    super.initState();
  }

  getDataFromPrefrences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      homeLocation = pref.getString('homeLocation');
    });
  }

  getPolyLine() async {
    latlong = [
      LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude),
      LatLng(latude, longtude)
    ];
    polyline.add(
      Polyline(
        polylineId: PolylineId('1'),
        color: Colors.indigo,
        points: latlong,
        width: 4,
      ),
    );
  }

  getLocationMarker(LatLng tapped) async {
    final Coordinates coor = new Coordinates(tapped.latitude, tapped.longitude);
    //var addressa =await Geocoder.google(mapKey).findAddressesFromCoordinates(coor);

    try {
      List<Address> address =
          await Geocoder.local.findAddressesFromCoordinates(coor);

      Address firstAddress = address.first;
      //print(firstAddress);
      setState(() {
        isEdit = true;
        adr = firstAddress.addressLine;
        contury = firstAddress.locality;
        subLocality = firstAddress.subLocality;
        latude = firstAddress.coordinates.latitude;
        longtude = firstAddress.coordinates.longitude;
        //put marker
        mymarker = [];
        mymarker = [
          /*   Marker(
              markerId: MarkerId('2'),
              position: LatLng(widget.initialPosition.latitude,
                  widget.initialPosition.longitude),
              icon:
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              infoWindow:
                  InfoWindow(snippet: '$subLocality', title: 'My location')), */
          Marker(
            markerId: MarkerId('1'),
            position: LatLng(tapped.latitude, tapped.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            draggable: true,
            infoWindow: InfoWindow(snippet: '$subLocality', title: '$adr'),
            onDragEnd: (dragPosition) async {
              final coor = new Coordinates(
                  dragPosition.latitude, dragPosition.longitude);
              List<Address> address =
                  await Geocoder.local.findAddressesFromCoordinates(coor);
              var add = address.first;
              setState(() {
                //latlong[1] = dragPosition;
                adr = add.addressLine;
                contury = add.locality;
                subLocality = add.subLocality;
              });
            },
          ),
        ];
        newGoogleMapController
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(address.first.coordinates.latitude,
              address.first.coordinates.longitude),
          zoom: 19,
          tilt: 30.0,
          //bearing: 90
        )));

        //newGoogleMapController.showMarkerInfoWindow(MarkerId("1"));
      });
    } on Exception catch (e) {
      print("$e");
    }

    //getPolyLine();
  }

  Future<void> updateHomeLocation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("homeLocation", adr.toString() + subLocality.toString());
    var map = {
      'id': pref.getString('id'),
      'home_address': adr.toString(),
      'lat': latude.toString(),
      'lon': longtude.toString(),
    };
    var url =
        Uri.parse('https://herobus.000webhostapp.com/api/updateStuAddress.php');
    final response = await http.post(url, body: map);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jseon = jsonDecode(response.body);
      if (jseon == 'Success') {
        displayTostMsg("Done", context);
        setState(() {
          mymarker = [];
          polyline = {};
          homeLocation = pref.getString("homeLocation");
          isEdit = false;
          adr = null;
          subLocality = null;
        });
      } else {
        displayTostMsg("allready set", context);
      }
    }
  }

  displayTostMsg(String msg, BuildContext ctx) {
    Fluttertoast.showToast(msg: msg);
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: paddingOfMap),
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.initialPosition.latitude,
                    widget.initialPosition.longitude),
                zoom: 14),
            onTap: getLocationMarker,
            polylines: polyline,
            mapType: MapType.normal,
            myLocationEnabled: true,
            trafficEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            indoorViewEnabled: true,
            mapToolbarEnabled: true,
            scrollGesturesEnabled: true,
            buildingsEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                newGoogleMapController = controller;
                paddingOfMap = 220;
              });
            },
            markers: Set.from(mymarker) /*  Set<Marker>.of(markers.values)  */,
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 2.1),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              color: Colors.white,
              onPressed: () {
                if (mymarker != null) {
                  setState(() {
                    mymarker = [];
                    newGoogleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(widget.initialPosition.latitude,
                          widget.initialPosition.longitude),
                      zoom: 17.44,
                      tilt: 30.0,
                      //bearing: 90
                    )));
                  });
                }
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
                        paddingIcon = 545;
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
                          'Press to Edit Home Location',
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
                    //height: 190,
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
                      padding: EdgeInsets.all(10),
                      //padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3),
                          Text(
                            "${adr ?? 'Press on Map to Selected Address..'} ",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          /*  Text(
                              "${adr ?? 'Press on Map to Selected Address..'} ${subLocality ?? ' '}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)), */
                          Card(
                            elevation: 8,
                            child: ListTile(
                              title: Text('Add Home Address'),
                              subtitle: Text(
                                  "${homeLocation ?? 'Press on Map to Selected Address..'}"
                                  //"${widget.homeLocation}"
                                  /*  "${adr ?? 'Press on Map to Selected Address..'} ${subLocality ?? ' '}" */),
                              leading:
                                  Icon(Icons.home, color: Colors.indigo[800]),
                              trailing: IconButton(
                                icon:
                                    isEdit ? Icon(Icons.add) : Icon(Icons.edit),
                                iconSize: 30,
                                color: Colors.red,
                                onPressed: () async {
                                  if (isEdit) {
                                    updateHomeLocation();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Text(''),
          /* 
                
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          //height: 190,
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
                            padding: EdgeInsets.all(10),
                            //padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 3),
                                Text(
                                  "${adr ?? 'Press on Map to Selected Address..'} ${subLocality ?? ' '}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                /*  Text(
                              "${adr ?? 'Press on Map to Selected Address..'} ${subLocality ?? ' '}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)), */
                                Card(
                                  elevation: 8,
                                  child: ListTile(
                                    title: Text('Add Home Address'),
                                    subtitle: Text(
                                        "${homeLocation ?? 'Press on Map to Selected Address..'}"
                                        //"${widget.homeLocation}"
                                        /*  "${adr ?? 'Press on Map to Selected Address..'} ${subLocality ?? ' '}" */),
                                    leading: Icon(Icons.home,
                                        color: Colors.indigo[800]),
                                    trailing: IconButton(
                                      icon: isEdit
                                          ? Icon(Icons.add)
                                          : Icon(Icons.edit),
                                      iconSize: 30,
                                      color: Colors.red,
                                      onPressed: () async {
                                        if (isEdit) {
                                          updateHomeLocation();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                   
              ],
            ),
          ), */
        ],
      ),
    );
  }
}
//SizedBox(height: 10),
// ignore: deprecated_member_use
/*  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.indigo[800]),
                            SizedBox(width: 10),
                            Text(
                              'Search Drop off',
                            ),
                          ],
                        ),
                      ),
                    ), */
//SizedBox(height: 15),
/*  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.home, color: Colors.indigo),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Home Address'),
                            SizedBox(height: 4),
                            Text('Your living home Address',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                          ],
                        ),
                        // SizedBox(width: 100),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        )
                      ],
                    ), */
//SizedBox(height: 5),
/*  Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5), */
/*     Row(
                      children: [
                        Icon(Icons.school, color: Colors.indigo),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add School Address'),
                            SizedBox(height: 4),
                            Text('Your School Address',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                          ],
                        ),
                        SizedBox(width: 110),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        )
                      ],
                    ), */
/* getaddress(Position position) async {
    String address =
        await AssistantMethods.serchCoordinateAddress(position, context);
    print('your address is $address');
  } */

/*  void getMarker(double lat, double lon) {
    MarkerId markerId = MarkerId(lat.toString() + lon.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, lon),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(snippet: adr));

    setState(() {
      markers[markerId] = _marker;
      // mymarker.add(_marker);
    });
  } */
/*on tap: (tapped) async {
              final coor =
                  new geocoder.Coordinates(tapped.latitude, tapped.longitude);
              var address = await geocoder.Geocoder.local
                  .findAddressesFromCoordinates(coor);
              var firstAddress = address.first;
              //getMarker(tapped.longitude, tapped.longitude);

              setState(() {
                adr = firstAddress.addressLine;
                contury = firstAddress.locality;
                subLocality = firstAddress.subLocality;
                latude = firstAddress.coordinates.latitude;
                longude = firstAddress.coordinates.longitude;
                //put marker
                mymarker = [];
                mymarker = [
                  Marker(
                      markerId: MarkerId('2'),
                      position: LatLng(widget.initialPosition.latitude,
                          widget.initialPosition.longitude),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                      infoWindow: InfoWindow(
                          snippet: '$subLocality', title: 'My location')),
                  Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(tapped.latitude, tapped.longitude),
                      draggable: true,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                      infoWindow:
                          InfoWindow(snippet: '$subLocality', title: '$adr')),
                ];
                /*   mymarker.add(Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(tapped.latitude, tapped.longitude),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    infoWindow:
                        InfoWindow(snippet: '$subLocality', title: '$adr'))); */
              });
              getPolyLine();
            }, */

// SizedBox(height: 20),
/*     Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 16,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text(
                              'Search Drop off',
                            ),
                          ],
                        ),
                      ),
                    ), */

/* Row(
                      children: [
                        Icon(Icons.home, color: Colors.grey),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Home'),
                            SizedBox(height: 4),
                            Text('Your living home Address',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                          ],
                        ),
                      ],
                    ), */
/*           SizedBox(height: 10),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.school, color: Colors.grey),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add School'),
                            SizedBox(height: 4),
                            Text('Your School Address',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                          ],
                        ),
                      ],
                    ), */

/*    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // ignore: deprecated_member_use
                          RaisedButton(
                            //splashColor: Colors.indigo[400],
                            color: Colors.indigo[400],
                            child: Row(
                              children: [
                                Icon(Icons.home, color: Colors.red),
                                SizedBox(width: 5),
                                Text(
                                  'Add Home',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            onPressed: () {},
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            //splashColor: Colors.indigo[400],
                            color: Colors.indigo[400],
                            child: Row(
                              children: [
                                Icon(Icons.school, color: Colors.red),
                                SizedBox(width: 5),
                                Text(
                                  'Add School',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),*/
