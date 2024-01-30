import 'package:flutter/material.dart';

import '../../../Utility/discardDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class Metals extends StatefulWidget {

  final List<Widget> pagesToNavigate;
  final int currentIndex;
  
  const Metals({
    super.key,
    required this.pagesToNavigate,
    required this.currentIndex,
  });

  @override
  State<Metals> createState() => _MetalsState();
}

class _MetalsState extends State<Metals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metals'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
      ),
      body: ListView(
        children: [
          MetalEntry(
            metalName: 'Aluminum',
            units: const ['mg/L-N', 'ug/L'],
            onUnitChanged: (unit) {
              // Implement your logic here
            },
            onValueChanged: (value) {
              // Implement your logic here
            },
          ),
          MetalEntry(
            metalName: 'Arsenic',
            units: const ['mg/L', 'ug/L'],
            onUnitChanged: (unit) {
              // Implement your logic here
            },
            onValueChanged: (value) {
              // Implement your logic here
            },
          ),
          MetalEntry(
            metalName: 'Calcium',
            units: const ['mg/L'],
            onUnitChanged: (unit) {
              // Implement your logic here
            },
            onValueChanged: (value) {
              // Implement your logic here
            },
          ),
          MetalEntry(
            metalName: 'Copper',
            units: const ['mg/L'],
            onUnitChanged: (unit) {
              // Implement your logic here
            },
            onValueChanged: (value) {
              // Implement your logic here
            },
          ),
          MetalEntry(
            metalName: 'Iron',
            units: const ['mg/L'],
            onUnitChanged: (unit) {
              // Implement your logic here
            },
            onValueChanged: (value) {
              // Implement your logic here
            },
          ),
          MetalEntry(
            metalName: 'Magnesium',
            units: const ['mg/L'],
            onUnitChanged: (unit) {
              // Implement your logic here
            },
            onValueChanged: (value) {
              // Implement your logic here
            },
          ),
          MetalEntry(
            metalName: 'Manganese',
            units: const ['mg/L'],
            onUnitChanged: (unit) {
              // Implement your logic here
            },
            onValueChanged: (value) {
              // Implement your logic here
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

class MetalEntry extends StatelessWidget {
  final String metalName;
  final List<String> units;
  final Function(String) onUnitChanged;
  final Function(double) onValueChanged;

  const MetalEntry({
    super.key,
    required this.metalName,
    required this.units,
    required this.onUnitChanged,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(metalName),
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
      ],
    );
    
  }
  
}

