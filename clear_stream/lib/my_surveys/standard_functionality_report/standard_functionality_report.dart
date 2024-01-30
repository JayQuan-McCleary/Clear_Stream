import 'package:clear_stream/Utility/sumbitDialogueBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Classes/marker_data.dart';
import '../../Map/map.dart';
import '../../Utility/checkBoxModel.dart';
import '../../Utility/discardDialogue.dart';
import '../../Utility/survey_model.dart';
import 'management.dart';

// ignore: library_private_types_in_public_api
_StandardFunctionalityReportState functionalityReportState =
    _StandardFunctionalityReportState();

// ignore: must_be_immutable
class StandardFunctionalityReport extends StatefulWidget {
  const StandardFunctionalityReport({super.key});

  @override
  State<StandardFunctionalityReport> createState() =>
      _StandardFunctionalityReportState();
}

class _StandardFunctionalityReportState
    extends State<StandardFunctionalityReport> {
  List<String> myPagesList = [];
  List<SurveyData> surveyDataList = [];
  DateTime selectedDate = DateTime.now();
  List<MarkerData> facilityMarkers = [];
  late CheckBoxesModel checkBoxesModel;
  String? selectedWaterPoint; // Declare the variable

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final ScrollController _scrollController = ScrollController();

  bool showAvailabilityFields = false;
  bool showHoursPerDayField = false;
  int? functionalityStatus;
  int? waterPointStatus;
  // ignore: prefer_typing_uninitialized_variables
  var selectedRadioValue;
  Widget conditionalWidget =
      const SizedBox(); // Initialize with a default value

  bool januaryChecked = false;
  bool februaryChecked = false;
  bool marchChecked = false;
  bool aprilChecked = false;
  bool mayChecked = false;
  bool juneChecked = false;
  bool julyChecked = false;
  bool augustChecked = false;
  bool septemberChecked = false;
  bool octoberChecked = false;
  bool novemberChecked = false;
  bool decemberChecked = false;
  bool monthUnsure = false;
  bool mapper = false;
  String selectedText = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Standard Functionality Report'),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Basic Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),

              const SizedBox(height: 20), // Add space

              Text(selectedText.isNotEmpty ? selectedText : 'No water point selected'),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Water point linked to this data'),
                  ElevatedButton(
                    onPressed: () async {
                      await _showListDialog(context);
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

              const SizedBox(height: 20), // Add space

              const Text(
                'Functionality Status',
                style: TextStyle(fontSize: 25),
              ),

              Column(
                children: [
                  RadioListTile(
                    title: const Text('Functional'),
                    value: 1,
                    groupValue: functionalityStatus,
                    onChanged: (value) {
                      setState(() {
                        functionalityStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                        'Partially functional but in need of repair'),
                    value: 2,
                    groupValue: functionalityStatus,
                    onChanged: (value) {
                      setState(() {
                        functionalityStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Not functional'),
                    value: 3,
                    groupValue: functionalityStatus,
                    onChanged: (value) {
                      setState(() {
                        functionalityStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('No Longer Exists'),
                    value: 4,
                    groupValue: functionalityStatus,
                    onChanged: (value) {
                      setState(() {
                        functionalityStatus = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20), // Add space

              const Text('Notes on Functionality Status'),
              Container(
                height: 120, // Adjust height as needed
                decoration: BoxDecoration(
                  border: Border.all(), // Add border for a square appearance
                  borderRadius:
                      BorderRadius.circular(8), // Optional: round corners
                ),
                child: const TextField(
                  maxLines: null, // Allows multiline input
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.all(8), // Adjust padding as needed
                    border: InputBorder.none, // Remove default TextField border
                    hintText: 'Enter notes here',
                  ),
                ),
              ),

              const SizedBox(height: 20), // Add space

              const Text('Please describe the repairs needed'),

              Container(
                height: 120, // Adjust height as needed
                decoration: BoxDecoration(
                  border: Border.all(), // Add border for a square appearance
                  borderRadius:
                      BorderRadius.circular(8), // Optional: round corners
                ),
                child: const TextField(
                  maxLines: null, // Allows multiline input
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.all(8), // Adjust padding as needed
                    border: InputBorder.none, // Remove default TextField border
                    hintText: 'Enter notes here',
                  ),
                ),
              ),

              const SizedBox(height: 20), // Add space

              const Text(
                'Will the Water Point be repaired or has it been abandoned',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20), // Add space
              Column(
                children: [
                  RadioListTile(
                    title: const Text(
                        'There are clear plans to fix the water point'),
                    value: 1,
                    groupValue: waterPointStatus,
                    onChanged: (value) {
                      setState(() {
                        waterPointStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                        'They want to fix the water point but plans are unclear'),
                    value: 2,
                    groupValue: waterPointStatus,
                    onChanged: (value) {
                      setState(() {
                        waterPointStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('The water point has been abandoned'),
                    value: 3,
                    groupValue: waterPointStatus,
                    onChanged: (value) {
                      setState(() {
                        waterPointStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Unsure'),
                    value: 4,
                    groupValue: waterPointStatus,
                    onChanged: (value) {
                      setState(() {
                        waterPointStatus = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20), // Add space

              Row(
                children: [
                  Checkbox(
                    value: mapper, // Store the checked value here
                    onChanged: (value) {
                      setState(() {
                        mapper = value ?? false;
                      });
                    },
                  ),
                  const Text('Add a Water Point Mapper'),
                ],
              ),
              const Text(
                  'Includes new questions and allows you to use the Clear Stream water point mapper tool'), // Replace with description when available
              const SizedBox(height: 20), // Add space

              Row(
                children: [
                  Checkbox(
                    value:
                        showAvailabilityFields, // Store the checked value here
                    onChanged: (value) {
                      setState(() {
                        showAvailabilityFields = value ?? false;
                      });
                    },
                  ),
                  const Text('Add availability and reliability information'),
                ],
              ),

              const SizedBox(height: 20), // Add space

              Visibility(
                visible: showAvailabilityFields,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Is water available at all times of day at this source?',
                      style: TextStyle(fontSize: 18),
                    ),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Yes'),
                          value: 'yes',
                          groupValue: selectedRadioValue,
                          onChanged: (value) {
                            setState(() {
                              selectedRadioValue = value;
                              showHoursPerDayField =
                                  false; // Hide the time input fields
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('No'),
                          value: 'no',
                          groupValue: selectedRadioValue,
                          onChanged: (value) {
                            setState(() {
                              selectedRadioValue = value;
                              showHoursPerDayField = value ==
                                  'no'; // Show time input fields when 'No' is selected
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Unsure'),
                          value: 'unsure',
                          groupValue: selectedRadioValue,
                          onChanged: (value) {
                            setState(() {
                              selectedRadioValue = value;
                              showHoursPerDayField =
                                  false; // Hide the time input fields
                            });
                          },
                        ),
                        if (showHoursPerDayField)
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'How many Hours per day is water available from this source?',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextField(
                                keyboardType: TextInputType
                                    .number, // Allow only number input
                                decoration: InputDecoration(
                                  hintText: 'Enter hours',
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20), // Add space

              const Text(
                'How many days in the past two weeks has water been unavailable from this source?',
                style: TextStyle(fontSize: 18),
              ),

              const TextField(
                keyboardType: TextInputType.number, // Allow only number input
                decoration: InputDecoration(
                  hintText: 'Enter days',
                ),
              ),

              const SizedBox(height: 20), // Add space

              const Text(
                'Is water available at all times of the year from this source?',
                style: TextStyle(fontSize: 18),
              ),
              Column(children: [
                RadioListTile<String>(
                  title: const Text('Yes'),
                  value: 'yes',
                  groupValue:
                      selectedRadioValue, // Store the selected value here
                  onChanged: (value) {
                    setState(() {
                      selectedRadioValue = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('No'),
                  value: 'no',
                  groupValue:
                      selectedRadioValue, // Store the selected value here
                  onChanged: (value) {
                    setState(() {
                      selectedRadioValue = value;
                      Future.delayed(const Duration(milliseconds: 500), () {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.easeOut,
                        );
                      });
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Unsure'),
                  value: 'unsure',
                  groupValue:
                      selectedRadioValue, // Store the selected value here
                  onChanged: (value) {
                    setState(() {
                      selectedRadioValue = value;
                    });
                  },
                ),
                if (selectedRadioValue == 'no')
                  Column(
                    children: [
                      CheckboxListTile(
                        title: const Text('January'),
                        value: januaryChecked,
                        onChanged: (value) {
                          setState(() {
                            januaryChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('February'),
                        value: februaryChecked,
                        onChanged: (value) {
                          setState(() {
                            februaryChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('March'),
                        value: marchChecked,
                        onChanged: (value) {
                          setState(() {
                            marchChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('April'),
                        value: aprilChecked,
                        onChanged: (value) {
                          setState(() {
                            aprilChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('May'),
                        value: mayChecked,
                        onChanged: (value) {
                          setState(() {
                            mayChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('June'),
                        value: juneChecked,
                        onChanged: (value) {
                          setState(() {
                            juneChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('July'),
                        value: julyChecked,
                        onChanged: (value) {
                          setState(() {
                            julyChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('August'),
                        value: augustChecked,
                        onChanged: (value) {
                          setState(() {
                            augustChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('September'),
                        value: septemberChecked,
                        onChanged: (value) {
                          setState(() {
                            septemberChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('October'),
                        value: octoberChecked,
                        onChanged: (value) {
                          setState(() {
                            octoberChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('November'),
                        value: novemberChecked,
                        onChanged: (value) {
                          setState(() {
                            novemberChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('December'),
                        value: decemberChecked,
                        onChanged: (value) {
                          setState(() {
                            decemberChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Unsure'),
                        value: decemberChecked,
                        onChanged: (value) {
                          setState(() {
                            monthUnsure = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
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
                        if (mapper == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Management()),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SubmitSurveyDialog();
                            },
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text('Next', style: TextStyle(fontSize: 14)),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {},
                      child: const Text('Save for Later',
                          style: TextStyle(fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {
                        // Show the discard survey dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DiscardSurveyDialog();
                          },
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
              ]),
            ]),
          ),
        ));
  }

  Future<MarkerData?> showMarkerSelectionDialog(BuildContext context) async {
    // Retrieve the facilityMarkers from MyMap widget
    final MyMap? myMapWidget = context.findAncestorWidgetOfExactType<MyMap>();
    if (myMapWidget == null) {
      return null;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Water Point'),
          content: Column(
            children: [
              for (var marker in facilityMarkers)
                ListTile(
                  title: Text(marker.name),
                  onTap: () {
                    handleSelectedMarker(marker);
                    // Pass the selected marker back to the previous screen
                    Navigator.pop(context, marker);
                  },
                ),
            ],
          ),
        );
      },
    );
    return null;
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

  void saveSurveyAsDraft(List<String> pages) {
    // Collect survey data
    SurveyData surveyData = SurveyData(
      date: selectedDate.toString(),
      waterpoint: selectedWaterPoint?.toString() ?? '',
      pages: myPagesList,
      // Add other survey data fields here
    );

    // Save the survey data as a draft
    Provider.of<SurveysModel>(context, listen: false)
        .saveSurveyDraft(surveyData);

    // Navigate back to MySurveys screen
    Navigator.pop(context);
  }

  Future<void> showMarkerListDialog(BuildContext context) async {
    // Retrieve the facilityMarkers from MyMap widget
    final MyMap? myMapWidget = context.findAncestorWidgetOfExactType<MyMap>();
    if (myMapWidget == null) {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Water Point'),
          content: Column(
            children: [
              for (var marker in facilityMarkers)
                ListTile(
                  title: Text(marker.name),
                  onTap: () {
                    handleSelectedMarker(marker);
                    // Pass the selected marker back to the previous screen
                    Navigator.pop(context, marker);
                  },
                ),
            ],
          ),
        );
      },
    );
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

