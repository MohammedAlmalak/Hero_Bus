/* import 'package:flutter/services.dart';

import 'package:location/location.dart';

class LocationServices {
  bool _serviceEnabled = true;
  PermissionStatus _permissionGranted;

  Future<void> checkLocationServicesInDevice() async {
    Location location = new Location();
    _serviceEnabled = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    // LocationData _userlocation;
    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        print('allow before');
        /*  _userlocation = await location.getLocation();

        double lat = _userlocation.latitude;
        double lon = _userlocation.longitude;
        print('lat= $lat' + '   long= $lon'); //print */

      } else {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          print('allow after');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          print('granted');
        } else {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == PermissionStatus.granted) {
            print('start tracking');
          } else {
            SystemNavigator.pop();
          }
        }
        print('start tracking');
      } else {
        SystemNavigator.pop();
      }
    }
  }
}
 */
