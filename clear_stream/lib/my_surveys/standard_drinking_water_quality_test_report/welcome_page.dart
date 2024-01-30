import 'package:clear_stream/Utility/checkBoxModel.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/selection_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Classes/marker_data.dart';
import '../../Map/map.dart';
import '../../Utility/discardDialogue.dart';
import '../../Utility/select_toast.dart';

class StandardDrinkingWaterQualityTest extends StatefulWidget {
  const StandardDrinkingWaterQualityTest({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StandardDrinkingWaterQualityTestState createState() =>
      _StandardDrinkingWaterQualityTestState();
}

class _StandardDrinkingWaterQualityTestState
    extends State<StandardDrinkingWaterQualityTest> {
  String selectedText = '';
  GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();
  List<MarkerData> facilityMarkers = [];

  String? selectedWaterPoint;
  late CheckBoxesModel checkBoxesModel;

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

  DateTime selectedDate = DateTime.now();
  // Variable to store the selected date

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Drinking Water Quality Test'),
        automaticallyImplyLeading:
            false, // Set this to false to remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title - Visit Information
                const Text(
                  'Visit Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

                // Container with text
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Grey color for the container
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'If you are not filling out this form all at once, you can save it for later by pressing the Save button at the bottom of the page. You will be given the oppurtunity to name the form. Saved forms will appear on the Survey Page under the Draft Surveys. When you are finished entering all data press the Submit button',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),

                // Water point selection button
                const SizedBox(height: 10),

                //end copy
                const Text(
                    'HIGHLY recommended you open Map atleast once in your app lifetime before clicking'),
              Text(selectedText.isNotEmpty ? selectedText : 'No water point selected'),
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

                //start copy

                // Buttons - Next, Save for Later, Discard
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                standardDrinkingWaterQualityTest_2(
                              key: UniqueKey(),
                              onCheckboxSelected: (Map<String, bool> values) {
                                // Update CheckBoxesModel values using the map provided
                                values.forEach((key, value) {
                                  checkBoxesModel.updateCheckboxValue(
                                      key, value);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Next'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showCustomToast('Not Available in Beta');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Save for Later'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Show the discard survey dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DiscardSurveyDialog();
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Discard'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
