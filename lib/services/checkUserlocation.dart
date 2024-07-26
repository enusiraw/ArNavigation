import 'package:ar_navigation/services/officelocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

Future<bool> checkUserLocation() async {
  
  GeoPoint officeLocation = await getOfficeLocation();
  
  Location location = Location();
  
  try {
    LocationData userLocation = await location.getLocation();
    if (userLocation.latitude == officeLocation.latitude &&
        userLocation.longitude == officeLocation.longitude) {
      return true; 
    } else {
      return false; 
    }
  } catch (e) {
    print("Error getting user location: $e");
    return false;
  }
}