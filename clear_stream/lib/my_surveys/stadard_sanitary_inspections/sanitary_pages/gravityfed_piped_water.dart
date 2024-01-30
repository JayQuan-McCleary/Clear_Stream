// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../../Utility/discardDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class gravity_water extends StatefulWidget {
  const gravity_water({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProtectedGravityWaterInspectionState createState() =>
      _ProtectedGravityWaterInspectionState();
}

class _ProtectedGravityWaterInspectionState extends State<gravity_water> {
  final Map<String, String> _selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sanitary Inspection'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Grav Piped-Water',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              const SizedBox(height: 5),
              const Text(
                'If you are uncertain about a particular question, answer "No".',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 15),
              _buildQuestion('1. Does the pipe leak between its source and Reservoir/StorageTank?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '2. Is the Reservoir/StorageTank cracked, damaged, or leaking?'),
              const SizedBox(height: 10),
              _buildQuestion('3. Are the vents and covers on the tank damaged or open?'),
              const SizedBox(height: 10),
              _buildQuestion('4. Do any TapStands leak?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '5. Does surface water collect around any TapStand?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '6. Is the are uphill of any TapStand eroded?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '7. Are pipes exposed close to any TapStand?'),
              const SizedBox(height: 10),
              _buildQuestion('8. Is human excreta on the ground within ten meters of any TapStand?'),
              const SizedBox(height: 10),
              _buildQuestion('9. Has there been discontinuity in the last 10 days at any TapStand?'),
              const SizedBox(height: 10),
              _buildQuestion('10. Are there signs of leaks in the main supply pipe in the system?'),
              const SizedBox(height: 10),
              _buildQuestion('11. Does the community report any pipe breaks in the last week?'),
              const SizedBox(height: 10),
              _buildQuestion('12. Is the main supply pipe exposed anywhere in the system?'),
              const SizedBox(height: 10),
              const Text(
                'Comments on Gravity fed piped water system Sanitary Inspection',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
              const SizedBox(height: 10),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SubmitSurveyDialog();
                    },
                  );                  },
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        RadioGroup(
          question: question,
          selectedValue: _selectedValues[question],
          onChanged: (value) {
            setState(() {
              _selectedValues[question] = value;
            });
          },
        ),
      ],
    );
  }
}

class RadioGroup extends StatelessWidget {
  final String question;
  final String? selectedValue;
  final ValueChanged<String>? onChanged;

  const RadioGroup({super.key, 
    required this.question,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Radio<String>(
              value: 'Yes',
              groupValue: selectedValue,
              onChanged: (value) => onChanged?.call(value ?? ''),
            ),
            const Text('Yes'),
          ],
        ),
        Row(
          children: <Widget>[
            Radio<String>(
              value: 'No',
              groupValue: selectedValue,
              onChanged: (value) => onChanged?.call(value ?? ''),
            ),
            const Text('No'),
          ],
        ),
      ],
    );
  }
}