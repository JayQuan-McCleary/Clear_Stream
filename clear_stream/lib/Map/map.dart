// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../Classes/marker_data.dart';
import 'package:routing_client_dart/routing_client_dart.dart';

import '../Utility/markerListDialogue.dart';

//Icon - Type link
final Map<String, IconData> typeToIcon = {
  'water_points': Icons.water_drop,
  'water_systems': Icons.wallet,
  'health_facilities': Icons.local_hospital,
  'dams': Icons.wallet,
  'irrigation_schemes': Icons.grass,
};

// ignore: must_be_immutable
class MyMap extends StatefulWidget {
  final GlobalKey<MyMapState> mapKey;

  const MyMap({super.key, required this.mapKey});

// Pass facilityMarkers to MyMap
  List<MarkerData> getAvailableMarkers() {
    MyMapState myMapState = MyMapState();
    return myMapState.facilityMarkers;
  }

  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  List<MarkerData> facilityMarkers = <MarkerData>[];
  List<Polyline> _polylines = [];

  @override
  void initState() {
    super.initState();
    addTenMarkers(); //Ten Dummy markers for reference
    getLocation();

// Set the initial point to the user's location
    if (currentLocation != null) {
      point = LatLng(
        currentLocation!.latitude,
        currentLocation!.longitude,
      );
    }
  }

// New method to get the list of available markers
  List<MarkerData> getAvailableMarkers() {
    return facilityMarkers;
  }

  Position? currentLocation; // Stores the user's location
  bool isSearchOptionsVisible = false; // Track visibility of search options

  List<MarkerData> getFilteredMarkers() {
    return facilityMarkers
        .where((marker) => selectedTypes.contains(marker.type))
        .toList();
  }

  List<MarkerData> searchResults = [];

//Helps in search optimization
  String capitalize(String s) {
    return s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;
  }

//Different Water Types assigned at random
  List<String> selectedTypes = [
    'water_points',
    'water_systems',
    'health_facilities',
    'dams',
    'irrigation_schemes'
  ];

  void searchMarkers(String query) {
    print('Search query: $query');

    setState(() {
// Clear previous search results
      searchResults.clear();

// Search for markers that match the query
      searchResults = facilityMarkers
          .where((marker) =>
              selectedTypes.contains(marker.type) &&
              marker.name
                  .toLowerCase()
                  .toString()
                  .contains(query.toLowerCase()))
          .toList();
    });
    print('Number of facility markers: ${facilityMarkers.length}');
    print('Search results: ${searchResults.length}');
  }

  final Location location = Location();

//Default Point if User Location Access isnt granted
  LatLng point = const LatLng(17.991387, -76.775384);
  double currentZoom = 15.0;

//Overly Complex get Location method but apparently all of these were needed
  void getLocation() async {
    try {
      LocationData locationData = await location.getLocation();
      currentLocation = Position(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
        altitude: locationData.altitude ?? 0.0,
        speed: locationData.speed ?? 0.0,
        speedAccuracy: locationData.speedAccuracy ?? 0.0,
        heading: locationData.heading ?? 0.0,
        accuracy: locationData.accuracy ?? 0.0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          locationData.time!.toInt(),
        ),
        headingAccuracy: locationData.headingAccuracy ?? 0.0,
        altitudeAccuracy: 0.0,
      );
      setState(() {
// Set the initial point to the user's location
        point = LatLng(
          currentLocation!.latitude,
          currentLocation!.longitude,
        );
      });
    } catch (e) {
      print('Error getting location: $e');
      showToast('Error getting location');
    }
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

//ZoomIn method for button
  void onZoomIn() {
    setState(() {
      currentZoom += 1.0;
      print('Zoom In: $currentZoom, Center: $point');
    });
  }

//ZoomOut method for button
  void onZoomOut() {
    setState(() {
      currentZoom -= 1.0;
      print('Zoom In: $currentZoom');
    });
  }

//Random 10 Markers
  void addTenMarkers() {
    print('Adding ten markers...');
    final List<String> customNames = [
      'Jamison',
      'Connie',
      'Steven',
      'Li.Gma',
      'Jonny',
      'Maria',
      'Kate',
      'Armin',
      'Levi',
      'Jay-Quan'
    ];

/*
Random LatLngs to be assigned with names
an icons to replace server Data as you can probably
guess would be an easy transition
*/

    final List<LatLng> randomLatLngs = [
      const LatLng(18.1096, -77.2975),
      const LatLng(18.0179, -76.8094),
      const LatLng(17.9838, -76.8670),
      const LatLng(18.1720, -76.4919),
      const LatLng(17.9770, -76.7674),
      const LatLng(17.9650, -76.7949),
      const LatLng(18.3341, -77.2805),
      const LatLng(18.1987, -77.3350),
      const LatLng(18.4500, -77.3833),
      const LatLng(17.9734, -76.9694),
    ];

//Complete radomization...Kinda
    for (int i = 0; i < 10; i++) {
      IconData? customIcon =
          typeToIcon[selectedTypes[i % selectedTypes.length]];

      String label;
      String typeName = capitalize(selectedTypes[i % selectedTypes.length]);
      String customName = customNames[i % customNames.length];

      switch (selectedTypes[i % selectedTypes.length]) {
        case 'water_points':
          label = 'Water Point: $customName';
          break;
        case 'water_systems':
          label = 'Water System: $customName';
          break;
        case 'health_facilities':
          label = 'Health Facility: $customName';
          break;
        case 'dams':
          label = 'Dam: $customName';
          break;
        case 'irrigation_schemes':
          label = 'Irrigation Scheme: $customName';
          break;
        default:
          label = 'Type $i';
      }

//Extension of MarkerData
      MarkerData markerData = MarkerData(
        coordinates: randomLatLngs[i],
        label: label,
        icon: customIcon ?? Icons.place,
        type: selectedTypes[i % selectedTypes.length],
        name: '$typeName $customName',
      );
      facilityMarkers.add(markerData);
    }

// Update the UI
    setState(() {});
  }

//Build Method FINALLY
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSearchOptionsVisible = false;
                  });
                },
                child: Column(
                  children: [
                    Row(
                      children: [
// Add button
                        SizedBox(
                          width: 70.0,
                          child: ElevatedButton(
                            onPressed: () {
                              showAddMarkerDialog(context);
                            },
                            child: const Text('Add'),
                          ),
                        ),
// Search bar
                        Expanded(
                          child: Listener(
                            onPointerDown: (PointerDownEvent event) {
// Close search options when clicking outside
                              setState(() {
                                isSearchOptionsVisible = false;
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Stack(
                                children: [
                                  TextField(
                                    focusNode: FocusNode(),
                                    onEditingComplete: () {
                                      setState(() {
                                        isSearchOptionsVisible = false;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        isSearchOptionsVisible = true;
                                      });
                                    },
                                    onChanged: searchMarkers,
                                    decoration: const InputDecoration(
                                      hintText: 'Search...',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  if (isSearchOptionsVisible)
                                    Positioned(
                                      top: 50.0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            for (var result in searchResults)
                                              Container(
                                                height: 50,
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
// Center the map on the selected marker
                                                    setState(() {
                                                      point =
                                                          result.coordinates;
// Reset hover effect for all markers
                                                      for (var result
                                                          in searchResults) {
                                                        result.isHovered =
                                                            false;
                                                      }
                                                      isSearchOptionsVisible =
                                                          false;
                                                    });
                                                  },
                                                  onHover: (hovered) {
// Add hover effect
                                                    setState(() {
                                                      result.isHovered =
                                                          hovered;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          _getIconData(
                                                              result.type),
                                                          size: 20,
                                                          color:
                                                              _getCheckboxColor(
                                                                  result.type),
                                                        ),
                                                        const SizedBox(
                                                            width: 8.0),
                                                        Expanded(
                                                          child: Text(
                                                            result.name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color: result
                                                                      .isHovered
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black,
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
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

// Filter button
                        SizedBox(
                          width: 70.0,
                          child: ElevatedButton(
                            onPressed: () {
// Toggle visibility of search options
                              setState(() {
                                isSearchOptionsVisible =
                                    !isSearchOptionsVisible;
                              });
                              showFilterDialog(context);
                            },
                            child: const Icon(Icons.filter_list),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FlutterMap(
                        key: UniqueKey(),
                        options: MapOptions(
                          initialCenter: point,
                          initialZoom: currentZoom,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              ...getFilteredMarkers()
                                  .map((markerData) => buildMarker(markerData)),
                              buildUserLocationMarker(), // Add the user's location marker here
                            ],
                          ),
                          PolylineLayer(polylines: _polylines)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (searchResults.isNotEmpty)
                Positioned(
                  top: 110.0,
                  left: 16.0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var result in searchResults)
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width *
                                .93, // Use MediaQuery to get screen width
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(result.name),
                                  onTap: () {
// Center the map on the selected marker
                                    setState(() {
                                      point = result.coordinates;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                top: 70.0,
                right: 16.0,
                child: Column(
                  children: [
                    FloatingActionButton(
                      onPressed: onZoomIn,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 8.0),
                    FloatingActionButton(
                      onPressed: onZoomOut,
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    if (currentLocation != null) {
                      setState(() {
                        point = LatLng(
                          currentLocation!.latitude,
                          currentLocation!.longitude,
                        );
                      });
                    } else {
                      showToast('User location not available');
                    }
                  },
                  child: const Icon(Icons.gps_fixed),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Icon Data linking with type for Add Marker method
  IconData _getIconData(String type) {
    return typeToIcon[type] ?? Icons.place;
  }

//Dialog Box for routing
  void showMarkerDialogForMarker(BuildContext context, Position userLocation,
      LatLng markerCoordinates, String markerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Marker: $markerName'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Do you want to route to this marker?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final manager = OSRMManager();
                final road = await manager.getTrip(
                  waypoints: [
                    LngLat(
                        lng: userLocation.longitude,
                        lat: userLocation.latitude),
                    LngLat(
                        lat: markerCoordinates.latitude,
                        lng: markerCoordinates.longitude),
                  ],
                  roundTrip: false,
                  source: SourceGeoPointOption.first,
                  destination: DestinationGeoPointOption.last,
                  geometries: Geometries.polyline,
                  steps: true,
                  language: Languages.en,
                );

                print('Road structure: ${road.toString()}');
// Extract coordinates from the road response
                List<LatLng> coordinates = [];

// Create a Polyline from the coordinates
                Polyline polyline = Polyline(
                  points: coordinates,
                  color: Colors.blue,
                  strokeWidth: 8.0,
                );

// Update the polylines list
                setState(() {
                  _polylines = [polyline];
                  print('Coordinates from OSRM: $coordinates');
                });

// Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Route'),
            ),
          ],
        );
      },
    );
  }

  Marker buildMarker(MarkerData markerData) {
    Color markerColor = _getCheckboxColor(markerData.type);
    return Marker(
      point: markerData.coordinates,
      width: 100,
      height: 50,
      child: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
// Show the marker dialog when the marker is tapped
              showMarkerDialogForMarker(context, currentLocation as Position,
                  markerData.coordinates, markerData.name);
            },
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    markerData.icon,
                    size: 20,
                    color: markerColor,
                  ),
                  Text(
                    markerData.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      backgroundColor: Colors.black,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

//Filter Ability
  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Markers'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  buildFilterCheckbox('Water Points', 'water_points'),
                  buildFilterCheckbox('Water Systems', 'water_systems'),
                  buildFilterCheckbox('Health Facilities', 'health_facilities'),
                  buildFilterCheckbox('Dams', 'dams'),
                  buildFilterCheckbox(
                      'Irrigation Schemes', 'irrigation_schemes'),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
// Call setState to trigger a rebuild of the markers
                setState(() {});
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

//Checkbox Filter Builder...Kinda proud of this one
  Widget buildFilterCheckbox(String title, String type) {
    Color checkboxColor = _getCheckboxColor(type);
    IconData iconData = _getIconData(type);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            Switch(
              value: selectedTypes.contains(type),
              onChanged: (bool value) {
                setState(() {
                  if (value) {
                    selectedTypes.add(type);
                  } else {
                    selectedTypes.remove(type);
                  }
                });
              },
              activeColor: checkboxColor,
              activeTrackColor: checkboxColor.withOpacity(0.5),
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
            Icon(
              iconData,
              size: 20,
              color: checkboxColor,
            ),
            Text(title),
          ],
        );
      },
    );
  }

//Color COordinating with the icons and markers
  Color _getCheckboxColor(String type) {
    switch (type) {
      case 'water_points':
        return Colors.blue;
      case 'water_systems':
        return Colors.green;
      case 'health_facilities':
        return Colors.red;
      case 'dams':
        return Colors.orange;
      case 'irrigation_schemes':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

//add Custom marker (USER)
  void addCustomMarker(
      LatLng coordinates, String name, String type, IconData icon) {
    MarkerData markerData = MarkerData(
      coordinates: coordinates,
      label: '$type: $name',
      icon: icon,
      type: type,
      name: name,
    );

    facilityMarkers.add(markerData);

// Update the UI
    setState(() {});
  }

  void showAddMarkerDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController latitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();
    LatLng newMarkerCoordinates = point;
    String selectedMarkerType = 'water_points'; // Default type

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Marker'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
// Dropdown menu for selecting marker type
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<String>(
                  value: selectedMarkerType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMarkerType = newValue!;
                    });
                  },
                  items: <String>[
                    'water_points',
                    'water_systems',
                    'health_facilities',
                    'dams',
                    'irrigation_schemes',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 10),
// TextFields for entering latitude and longitude
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: latitudeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Latitude'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: longitudeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Longitude'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Marker Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                IconData selectedIcon =
                    typeToIcon[selectedMarkerType] ?? Icons.place;
// Parse latitude and longitude
                double latitude =
                    double.tryParse(latitudeController.text) ?? 0.0;
                double longitude =
                    double.tryParse(longitudeController.text) ?? 0.0;

// Set the new marker coordinates
                newMarkerCoordinates = LatLng(latitude, longitude);

// Add the new marker with the provided name, coordinates, and type
                String markerName = nameController.text.trim();
                if (markerName.isNotEmpty) {
                  addCustomMarker(newMarkerCoordinates, markerName,
                      selectedMarkerType, selectedIcon);
                  showToast('Marker added: $markerName');
                } else {
                  showToast('Please enter a valid marker name');
                }

// Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Add Marker'),
            ),
          ],
        );
      },
    );
  }

  Marker buildUserLocationMarker() {
    return Marker(
      point: LatLng(
        currentLocation?.latitude ?? 0.0,
        currentLocation?.longitude ?? 0.0,
      ),
      width: 100,
      height: 50,
      child: Container(
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .location_on, // You can replace this with your preferred icon
              size: 20,
              color: Colors.blue, // You can customize the color
            ),
            Text(
              'Your Location',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                backgroundColor: Colors.black,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCloseButton() {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        setState(() {
          isSearchOptionsVisible = false;
        });
      },
    );
  }

  void showMarkerListDialog(BuildContext context) {
    List<String> markerNames =
        facilityMarkers.map((marker) => marker.name).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MarkerListDialog(
          markerNames: markerNames,
          onMarkerSelected: (selectedMarker) {
// Handle the selected marker (you can update your UI or do other actions)
            print('Selected Marker: $selectedMarker');
          },
        );
      },
    );
  }
}
