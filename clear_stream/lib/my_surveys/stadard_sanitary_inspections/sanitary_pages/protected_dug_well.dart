import 'package:flutter/material.dart';

import '../../../Utility/discardDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class ProtectedDugWellInspection extends StatefulWidget {
  const ProtectedDugWellInspection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProtectedDugWellInspectionState createState() =>
      _ProtectedDugWellInspectionState();
}

class _ProtectedDugWellInspectionState
    extends State<ProtectedDugWellInspection> {
  final Map<String, String> _selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sanitary Inspection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Protected Dug-Well',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              const SizedBox(height: 5),
              const Text(
                'If you are uncertain about a particular question, answer "No".',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 15),
              _buildQuestion(
                  '1. Is there a latrine within 10 meters of the well?'),
              const SizedBox(height: 10),
              _buildQuestion('2. Is the nearest latrine uphill of the well?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '3. Is there any other source of pollution within 10 meters of the well?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '4. Is the drainage faulty, allowing ponding within two meters of the well?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '5. Is the drainage channel cracked, broken, or needing cleaning?'),
              const SizedBox(height: 10),
              _buildQuestion('6. Is the fence missing or faulty?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '7. Is the apron less than one meter in radius around the well cover?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '8. Does spilled water collect in the apron area?'),
              const SizedBox(height: 10),
              _buildQuestion('9. Are there cracks in the cement floor?'),
              const SizedBox(height: 10),
              _buildQuestion(
                  '10. Is the hand pump loose at the point of attachment to the well head?'),
              const SizedBox(height: 10),
              _buildQuestion('11. Is the cover of the well sanitary?'),
              const SizedBox(height: 10),
              const Text(
                'Comments on Protected Dug Well Sanitary Inspection',
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