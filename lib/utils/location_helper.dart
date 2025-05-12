import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> ensureLocationIsEnabled(BuildContext context) async {
  final location = Location();

  var permissionStatus = await Permission.location.request();
  if (!permissionStatus.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Location permission is required.")),
    );
    return false;
  }

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enable location services.")),
      );
      return false;
    }
  }

  return true;
}
