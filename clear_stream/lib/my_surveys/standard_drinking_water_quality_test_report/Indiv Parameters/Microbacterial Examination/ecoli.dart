import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../Utility/discardDialogue.dart';
import '../../../../Utility/photoSelectionDialogue.dart';
import '../../../../Utility/select_toast.dart';
import '../../../../Utility/sumbitDialogueBox.dart';

class EColitestingForm extends StatefulWidget {
  final List<Widget> pagesToNavigate;
  final int currentIndex;

  const EColitestingForm(
      {super.key, required this.pagesToNavigate, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _EColitestingFormState createState() => _EColitestingFormState();
}

class _EColitestingFormState extends State<EColitestingForm> {
  String? imageFilePath;
  List<String> selectedMethods = [];

  String plateCountMethod = 'Pour Plate';

  // Variables to store user input
  String eColiMethod = '';
  double sampleVolume = 0.0;
  String eColiPresenceAbsenceResult = 'Negative';
  double volumeFiltered = 100.0;
  int eColiCount = 0;
  int mostProbableNumber = 0;
  List<int> compartmentsChangedColor = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('E. coli Testing Form'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const Text('Which E.Coli methods are you using',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: selectedMethods.contains('Presence/Absence'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedMethods.add('Presence/Absence');
                    } else {
                      selectedMethods.remove('Presence/Absence');
                    }
                  });
                },
              ),
              const Text('Presence/Absence'),
            ],
          ),

          Row(
            children: [
              Checkbox(
                value: selectedMethods.contains('Membrane Filtration'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedMethods.add('Membrane Filtration');
                    } else {
                      selectedMethods.remove('Membrane Filtration');
                    }
                  });
                },
              ),
              const Text('Membrane Filtration'),
            ],
          ),

          Row(
            children: [
              Checkbox(
                value: selectedMethods.contains('Most Probable Number (MPN)'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedMethods.add('Most Probable Number (MPN)');
                    } else {
                      selectedMethods.remove('Most Probable Number (MPN)');
                    }
                  });
                },
              ),
              const Text('Most Probable Number (MPN)'),
            ],
          ),

          Row(
            children: [
              Checkbox(
                value: selectedMethods.contains('Compartment Bag Test (CBT)'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedMethods.add('Compartment Bag Test (CBT)');
                    } else {
                      selectedMethods.remove('Compartment Bag Test (CBT)');
                    }
                  });
                },
              ),
              const Text('Compartment Bag Test (CBT)'),
            ],
          ),

          Row(
            children: [
              Checkbox(
                value: selectedMethods.contains('Plate'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedMethods.add('Plate');
                    } else {
                      selectedMethods.remove('Plate');
                    }
                  });
                },
              ),
              const Text('Plate'),
            ],
          ),
          Visibility(
            visible: selectedMethods.contains('Presence/Absence'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('E. coli Presence:'),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: sampleVolume.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'E. coli Presence',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              sampleVolume = double.parse(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text('E. coli Presence/Absence Result:'),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Positive',
                      groupValue: eColiPresenceAbsenceResult,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            eColiPresenceAbsenceResult = value;
                          });
                        }
                      },
                    ),
                    const Text('Positive'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Negative',
                      groupValue: eColiPresenceAbsenceResult,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            eColiPresenceAbsenceResult = value;
                          });
                        }
                      },
                    ),
                    const Text('Negative'),
                  ],
                ),
              ],
            ),
          ),

          // Membrane Filtration Section
          Visibility(
            visible: selectedMethods.contains('Membrane Filtration'),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Volume Filtered (mL):'),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: volumeFiltered.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Volume Filtered',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              volumeFiltered = double.parse(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Text('E. coli Count (CFU):'),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: eColiCount.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'E. coli Count (CFU)',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              eColiCount = int.parse(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Most Probable Number (MPN) Section
          Visibility(
            visible: selectedMethods.contains('Most Probable Number (MPN)'),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Most Probable Number'),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: mostProbableNumber.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: '(MPN/100 mL)',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              mostProbableNumber = int.parse(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Compartment Bag Test (CBT) Section
          Visibility(
              visible: selectedMethods.contains('Compartment Bag Test (CBT)'),
              child: Column(children: [
                const Text(
                    'Which compartments have changed color to blue or green? (Aquagenx Compartment Bag Test)'),
                const SizedBox(height: 5),
                const Text('Order below is from leftmost to rightmost'),
                CheckboxListTile(
                  value: compartmentsChangedColor.contains(1),
                  title: const Text('Compartment 1 (10mL)'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        compartmentsChangedColor.add(1);
                      } else {
                        compartmentsChangedColor.remove(1);
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  value: compartmentsChangedColor.contains(2),
                  title: const Text('Compartment 2 (30mL)'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        compartmentsChangedColor.add(2);
                      } else {
                        compartmentsChangedColor.remove(2);
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  value: compartmentsChangedColor.contains(3),
                  title: const Text('Compartment 3 (56mL)'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        compartmentsChangedColor.add(3);
                      } else {
                        compartmentsChangedColor.remove(3);
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  value: compartmentsChangedColor.contains(4),
                  title: const Text('Compartment 4 (3mL)'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        compartmentsChangedColor.add(4);
                      } else {
                        compartmentsChangedColor.remove(4);
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  value: compartmentsChangedColor.contains(5),
                  title: const Text('Compartment 5 (1mL)'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        compartmentsChangedColor.add(5);
                      } else {
                        compartmentsChangedColor.remove(5);
                      }
                    });
                  },
                ),
                const Text('Photo of Compartment Bag Test'),
                //end copy

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () async {
                    // Show the PhotoSelectionDialog and wait for the result
                    final selectedImage = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const PhotoSelectionDialog();
                      },
                    );

                    // If the user selected an image, update the image in the container
                    if (selectedImage != null) {
                      setState(() {
                        imageFilePath = selectedImage;
                      });
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: imageFilePath != null
                        ? Image.file(File(imageFilePath!))
                        : const Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.black54,
                            ),
                          ),
                  ),
                ),

                //start copy
              ])),

          // Plate Section
          Visibility(
            visible: selectedMethods.contains('Plate'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                const Text('Plate Count Method:'),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Pour Plate',
                      groupValue: plateCountMethod,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            plateCountMethod = value;
                          });
                        }
                      },
                    ),
                    const Text('Pour Plate'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Compact Dry EC Plate',
                      groupValue: plateCountMethod,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            plateCountMethod = value;
                          });
                        }
                      },
                    ),
                    const Text('Compact Dry EC Plate'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Petrifilm',
                      groupValue: plateCountMethod,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            plateCountMethod = value;
                          });
                        }
                      },
                    ),
                    const Text('Petrifilm'),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text('Volume added to plate:'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Volume (mL)',
                        ),
                        onChanged: (value) {
                          // Handle the volume input
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    DropdownButton<String>(
                      value: 'mL', // Set the initial value
                      onChanged: (String? value) {
                        // Handle the dropdown selection
                      },
                      items: <String>['mL', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text('E. coli Count:'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: eColiCount.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'E. coli Count (CFU)',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              eColiCount = int.parse(value);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    DropdownButton<String>(
                      value: 'Colony Forming Units', // Set the initial value
                      onChanged: (String? value) {
                        // Handle the dropdown selection
                      },
                      items: <String>['Colony Forming Units', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
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
                onPressed: () async {
                  // Action for 'Next' button
                  if (widget.currentIndex + 1 < widget.pagesToNavigate.length) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            widget.pagesToNavigate[widget.currentIndex + 1],
                      ),
                    );
                  } else {
                    // ignore: unused_local_variable
                    bool submitSurvey = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SubmitSurveyDialog();
                      },
                    );
                    // Handle the result of the dialog if needed
                  }
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 14)),
              ),
              TextButton(
                onPressed: () {
                  showCustomToast('Not Available in Beta');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
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
                child: const Text('Discard', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ])));
  }
}
