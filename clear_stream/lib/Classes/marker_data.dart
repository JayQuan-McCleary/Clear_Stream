import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MarkerData {
  final LatLng coordinates;
  final String label;
  final IconData icon;
  final String type;
  final String name; 
  bool isHovered; 



  MarkerData({
    required this.coordinates,
    required this.label,
    required this.icon,
    required this.type,
    required this.name,
    this.isHovered = false,
  });
}
