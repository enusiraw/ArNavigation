import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Departments {
  final String departmentId;
  final String name;
  final GeoPoint location;
  final String? description;
  final int? floorNumber;
  final String? image;

  Departments({
    required this.departmentId,
    required this.name,
    required this.location,
    this.image,
    this.description,
    this.floorNumber,
  });
  factory Departments.fromJson(Map<String, Object?> json) => Departments(
        // Use factory for creating objects from data
        departmentId: json["departmentId"]! as String,
        name: json["name"]! as String,
        location: json["location"]! as GeoPoint,
        description: json["description"]! as String,
        floorNumber: json["floorNumber"] as int?,
        //image: json["image"]! as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'descripiton': description.toString(),
      'floor Number': floorNumber.toString(),
      'location': location,
      'department': departmentId
    };
  }

  double calculateDistance(double userX, double userY) {
    return sqrt(
        pow(location.latitude - userX, 2) + pow(location.longitude - userY, 2));
  }

  Map<String, double> toMapMarkerPosition() {
    return {'latitude': location.latitude, 'longitude': location.longitude};
  }
}
