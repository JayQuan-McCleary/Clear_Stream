// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../../Utility/discardDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class Piped_Water extends StatefulWidget {
  const Piped_Water({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProtectedPipedWaterInspectionState createState() =>
      _ProtectedPipedWaterInspectionState();
}

class _ProtectedPipedWaterInspectionState extends State<Piped_Water> {
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
                'Piped Water',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              const SizedBox(height: 5),
              const Text(
                'If you are uncertain about a particular question, answer "No".',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 15),
              _buildQuestion('1. Do any Tap STands leak at the sample site?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '2. Does surface water collect around any Tap Stand?'),
              const SizedBox(height: 10),
              _buildQuestion('3. Is the area uphill of any tapstand eroded?'),
              const SizedBox(height: 10),
              _buildQuestion('4. Are pipes exposed close to any Tap Stand?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '5. Is human excreta on the ground within ten meters of any tap Stand?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '6. Is there a sewer or latrine within 30 meters of the tap?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '7. Has there been discontinuity in the last ten days?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '8. Has there been signs of leakage in the main pipes of these areas?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '9. Have users reported any pipe breaks within the last week?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '10. Is the supply main pipeline exposed in the area?'),
              const SizedBox(height: 10),
              const Text(
                'Comments on Piped Water to TapStand Sanitary Inspection',
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

  const RadioGroup({
    super.key,
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
