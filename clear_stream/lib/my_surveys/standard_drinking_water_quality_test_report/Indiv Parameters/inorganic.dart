import 'package:flutter/material.dart';

import '../../../Utility/discardDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class InorganicChemicals extends StatefulWidget {

  final List<Widget> pagesToNavigate;
  final int currentIndex;

  const InorganicChemicals({super.key, 
  required this.currentIndex, 
  required this.pagesToNavigate
  });

  @override
  // ignore: library_private_types_in_public_api
  _InorganicChemicalsState createState() => 
  _InorganicChemicalsState();
}

class _InorganicChemicalsState extends State<InorganicChemicals> {
  String selectedUnit = 'mg/L';
  String selectedMethod = 'Blank';
  double inputValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inorganic Chemicals'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
      ),
      body: ListView(
        children: [
          ChemicalEntry(
            chemicalName: 'Ammonia',
            units: const ['mg/L-N', 'mg/L-NH3'],
            methods: const [],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),
          ChemicalEntry(
            chemicalName: 'Boron',
            units: const ['mg/L', 'hg/L', 'ppm', 'ppb'],
            methods: const [],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),
          ChemicalEntry(
            chemicalName: 'Chloride',
            units: const ['mg/L', 'ppm'],
            methods: const [],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),
          ChemicalEntry(
            chemicalName: 'Fluoride',
            units: const ['mg/L', 'ppm'],
            methods: const [
              'Blank',
              'Electrode',
              'Colorimeter',
              'Ion Chromatography'
            ],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onMethodChanged: (method) {
              setState(() {
                selectedMethod = method;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),

          ChemicalEntry(
            chemicalName: 'Nitrate',
            units: const ['mg/L', 'ppm'],
            methods: const [
              'Blank',
              'Electrode (ISE)',
              'Colorimeter (cadmium reduction method)',
              'Test Strip',
              'UV Spectrophotometer',
              'Ion chromotography'
            ],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onMethodChanged: (method) {
              setState(() {
                selectedMethod = method;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),
          ChemicalEntry(
            chemicalName: 'Nitrite',
            units: const ['mg/L', 'mg/L-NO2'],
            methods: const [],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),
          ChemicalEntry(
            chemicalName: 'Phosphate',
            units: const ['mg/L-P', 'mg/L-PO3'],
            methods: const [],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),
          ChemicalEntry(
            chemicalName: 'Sulphate',
            units: const ['mg/L-SO4'],
            methods: const [],
            onUnitChanged: (unit) {
              setState(() {
                selectedUnit = unit;
              });
            },
            onValueChanged: (value) {
              setState(() {
                inputValue = value;
              });
            },
          ),
            // Navigation Buttons
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
                      if (widget.currentIndex + 1 <
                          widget.pagesToNavigate.length) {
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
                    child:
                        const Text('Discard', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),  
        ],
      ),
    );
  }
}

class ChemicalEntry extends StatelessWidget {
  final String chemicalName;
  final List<String> units;
  final List<String> methods;
  final Function(String) onUnitChanged;
  final Function(String)? onMethodChanged;
  final Function(double) onValueChanged;

  const ChemicalEntry({
    super.key,
    required this.chemicalName,
    required this.units,
    required this.methods,
    required this.onUnitChanged,
    this.onMethodChanged,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(chemicalName),
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Value'),
                onChanged: (value) {
                  onValueChanged(double.parse(value));
                },
              ),
            ),
            DropdownButton<String>(
              value: units[0],
              items: units.map((unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (unit) {
                onUnitChanged(unit!);
              },
            ),
          ],
        ),
        if (methods.isNotEmpty)
          Row(
            children: [
              const Text('Select Method:'),
              DropdownButton<String>(
                value: methods[0],
                items: methods.map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (method) {
                  onMethodChanged!(method!);
                },
              ),
            ],
          ),
      ],
    );
  }
}
