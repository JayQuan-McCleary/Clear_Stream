import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/sanitary_pages/borehole.dart';
import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/sanitary_pages/deep_borehole.dart';
import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/sanitary_pages/gravityfed_piped_water.dart';
import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/sanitary_pages/household_container.dart';
import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/sanitary_pages/piped_water.dart';
import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/sanitary_pages/protected_spring.dart';
import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/sanitary_pages/rainwater.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../Classes/marker_data.dart';
import '../../Map/map.dart';
import '../../StartUp/homepage.dart';
import '../../Utility/checkBoxModel.dart';
import '../../Utility/select_toast.dart';
import 'sanitary_pages/protected_dug_well.dart';

class WaterPointInfo extends StatefulWidget {
  const WaterPointInfo({super.key});

  @override
  State<WaterPointInfo> createState() => _WaterPointInfoState();
}

class _WaterPointInfoState extends State<WaterPointInfo> {
  GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();
  List<MarkerData> facilityMarkers = [];
  late CheckBoxesModel checkBoxesModel;
  String? selectedWaterPoint;
  DateTime selectedDate = DateTime.now();

  String waterPoint = '';
  String selectedText = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkBoxesModel = Provider.of<CheckBoxesModel>(context);
    // Now you can use checkBoxesModel

    MyMap myMap = MyMap(
      mapKey: myMapKey,
    );
    facilityMarkers = myMap.getAvailableMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Points'),
        automaticallyImplyLeading:
            false, // Set this to false to remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(selectedText.isNotEmpty
                  ? selectedText
                  : 'No water point selected'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Water point linked to this data'),
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
                  ElevatedButton(
                    onPressed: () {
                      // Show Date Picker
                      _selectDate(context);
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),

              const SizedBox(height: 23),

              const Text(
                'Type of System',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  RadioListTile(
                    title: const Text('Protected Dug Well'),
                    subtitle: const Text("Dug Well with handpump/windlass"),
                    value: 'protected_dug_well',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Protected Spring'),
                    value: 'protected_spring',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                      // Handle radio button selection
                    },
                  ),
                  RadioListTile(
                    title: const Text('Borehole/Tubewell'),
                    value: 'borehole',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Deep Borehole with mechanized pumping'),
                    value: 'deep_borehole',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Piped Water to tapstand'),
                    value: 'piped_water',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Gravity-fed piped water'),
                    value: 'gravity',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Household water container'),
                    value: 'household',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Rainwater Collection and Storage'),
                    value: 'rainwater',
                    groupValue:
                        waterPoint, // Define the selected value variable
                    onChanged: (value) {
                      setState(() {
                        waterPoint = value.toString();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Back', style: TextStyle(fontSize: 14)),
                  ),
                  TextButton(
                    onPressed: () {
                      if (waterPoint.isEmpty) {
                        showCustomToast('Please Choose a Water Point');
                      } else {
                        navigateToScreen(waterPoint);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Next', style: TextStyle(fontSize: 14)),
                  ),
                  TextButton(
                    onPressed: () {
                      showCustomToast('Feature coming soon');
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Save for Later',
                        style: TextStyle(fontSize: 14)),
                  ),
                  TextButton(
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
                        msg: 'Survey Discarded',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child:
                        const Text('Discard', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToScreen(String value) {
    if (value == 'protected_dug_well') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ProtectedDugWellInspection()),
      );
    } else if (value == 'protected_spring') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ProtectedSpringInspection()),
      );
    } else if (value == 'borehole') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BoreHole()),
      );
    } else if (value == 'deep_borehole') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const deep_borehole()),
      );
    } else if (value == 'piped_water') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Piped_Water()),
      );
    } else if (value == 'gravity') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const gravity_water()),
      );
    } else if (value == 'household') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const House_Hold()),
      );
    } else if (value == 'rainwater') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Rain_Water()),
      );
    }
  }

  void handleSelectedMarker(MarkerData selectedMarker) {
    // Do something with the selected marker data
    setState(() {
      // Update the state or perform other actions
      selectedWaterPoint = selectedMarker.name;
    });
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
