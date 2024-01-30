// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Classes/marker_data.dart';
import '../../Map/map.dart';
import '../../StartUp/homepage.dart';
import '../../Utility/photoSelectionDialogue.dart';

void main() {
  runApp(const MaterialApp(
    home: Asset(),
  ));
}

class Asset extends StatefulWidget {
  const Asset({super.key});

  @override
  _AssetState createState() => _AssetState();
}

class _AssetState extends State<Asset> {
  GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();
  List<MarkerData> facilityMarkers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyMap myMap = MyMap(
      mapKey: myMapKey,
    );
    facilityMarkers = myMap.getAvailableMarkers();
  }

  List<String?> imageFilePaths = [];
  DateTime selectedDate = DateTime.now();
  String? imageFilePath;
  String? selectedWaterPoint;
  String assetStatus = '';
  String description = '';
  String selectedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Asset issue'),
          automaticallyImplyLeading:
              false, // Set this to false to remove the back button
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Issues allow you to follow up on a problem with a water point.'
                      'Once you create this issue, it will appear at the bottom of the water point page.'
                      'You can assign it to yourself or another user, add an update or mark it as resolved once the problem is fixed.'
                      'Issues that you created or that are assigned to you appear in the Issues tab in Tasks.'
                      'This is a public issue that all users will be able to view and update.'
                      'Contact Clear Stream, about creating custom issues designed for your organization.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(selectedText.isNotEmpty
                      ? selectedText
                      : 'No water point selected'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Water point linked to this data'),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () async {
                          _showListDialog(context);
                        },
                        child: const Text('Select'),
                      ),
                    ],
                  ),

// Text - Date of test Conducted with Calendar Input
                  const SizedBox(height: 10),
                  Text('$selectedDate'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date of test Conducted'),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
// Show Date Picker
                          _selectDate(context);
                        },
                        child: const Text('Select Date'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Type of Issue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile<String>(
                        title: const Text('Functional'),
                        value: 'Functional',
                        groupValue: assetStatus,
                        onChanged: (value) {
                          setState(() {
                            assetStatus = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Partially functional'),
                        value: 'Partially functional',
                        groupValue: assetStatus,
                        onChanged: (value) {
                          setState(() {
                            assetStatus = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Not functional'),
                        value: 'Not functional',
                        groupValue: assetStatus,
                        onChanged: (value) {
                          setState(() {
                            assetStatus = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Decommissioned'),
                        value: 'Decommissioned',
                        groupValue: assetStatus,
                        onChanged: (value) {
                          setState(() {
                            assetStatus = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description of Problem',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: 5,
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter a detailed description...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text('Photos of Problem (Optional)'),

                  const SizedBox(height: 10),

// Display selected images in a horizontal ListView
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageFilePaths.length +
                          1, // +1 for the add photo button
                      itemBuilder: (context, index) {
                        if (index == imageFilePaths.length) {
// Add photo button
                          return GestureDetector(
                            onTap: () async {
// Show the PhotoSelectionDialog and wait for the result
                              final selectedImage = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PhotoSelectionDialog();
                                },
                              );

// If the user selected an image, add it to the list
                              if (selectedImage != null) {
                                setState(() {
                                  imageFilePaths.add(selectedImage);
                                });
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          );
                        } else {
// Display selected image
                          return GestureDetector(
                            onTap: () {
// Open a dialog or perform any action when tapping on an existing image
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image:
                                      FileImage(File(imageFilePaths[index]!)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      myMapKey: myMapKey,
                                    )),
                          );
// Show toast message
                          Fluttertoast.showToast(
                            msg: 'Issue Not Submitted / Reasons:Beta',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      myMapKey: myMapKey,
                                    )),
                          );
// Show toast message
                          Fluttertoast.showToast(
                            msg: 'Issue Discarded',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        },
                        child: const Text('Discard'),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _showListDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Water Point'),
          content: Column(
            children: [
              ListTile(
                title: const Text('WaterPoint Jamison'),
                onTap: () {
                  _handleSelection('Jamison');
                },
              ),
              ListTile(
                title: const Text('Water System Connie'),
                onTap: () {
                  _handleSelection('Connie');
                },
              ),
              ListTile(
                title: const Text('Health Facility Steven'),
                onTap: () {
                  _handleSelection('Steven');
                },
              ),
              ListTile(
                title: const Text('Dam Li.Gma'),
                onTap: () {
                  _handleSelection('Ligma');
                },
              ),
              ListTile(
                title: const Text('Irrigation Scheme Johnny'),
                onTap: () {
                  _handleSelection('Johnny');
                },
              ),
              ListTile(
                title: const Text('WaterPoint Maria'),
                onTap: () {
                  _handleSelection('Maria');
                },
              ),
              ListTile(
                title: const Text('Water System Kate'),
                onTap: () {
                  _handleSelection('Kate');
                },
              ),
              ListTile(
                title: const Text('Health Facility Armin'),
                onTap: () {
                  _handleSelection('Armin');
                },
              ),
              ListTile(
                title: const Text('Dams Levi'),
                onTap: () {
                  _handleSelection('Levi');
                },
              ),
              ListTile(
                title: const Text('Irrigation Scheme Jay-Quan'),
                onTap: () {
                  _handleSelection('Jay-Quan');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSelection(String selectedItem) {
    setState(() {
      selectedText = selectedItem;
    });
    Navigator.pop(context); // Close the dialog
  }
}
