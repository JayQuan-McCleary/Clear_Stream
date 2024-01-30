// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../Utility/discardDialogue.dart';
import '../../Utility/select_toast.dart';
import 'access.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {

  int? feeCollection;
  int? externalFunds;
  int? waterPointManager;
  int? supportAvailability;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Are user fees or tariffs being collected?',
              style: TextStyle(fontSize: 18),
            ),
            buildRadioTiles(
              [
                'Yes, As Agreed',
                'Yes, only when there is a breakdown',
                'Yes, but not as agreed',
                'No',
                'Don\'t Know',
              ],
              feeCollection,
              (value) {
                setState(() {
                  feeCollection = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '2. Are external funds available (from outside the community) to cover the major cost of maintenance?',
              style: TextStyle(fontSize: 18),
            ),
            buildRadioTiles(
              ['Yes', 'No', 'Don\'t Know'],
              externalFunds,
              (value) {
                setState(() {
                  externalFunds = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '3. Who is currently managing the Water Point?',
              style: TextStyle(fontSize: 18),
            ),
            buildRadioTiles(
              [
                'Community Members',
                'WASH Committee',
                'Local Government',
                'Public Operators (Utilities)',
                'Institution (e.g., School, Health Centre, Religious Institution, Household, Nobody, Don\'t Know)',
              ],
              waterPointManager,
              (value) {
                setState(() {
                  waterPointManager = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '4. If there is a complicated breakdown, do you know where to get support from?',
              style: TextStyle(fontSize: 18),
            ),
            buildRadioTiles(
              [
                'Yes, As Agreed',
                'Yes, only when there is a breakdown',
                'Yes, but not as agreed',
                'No',
                'Don\'t Know',
              ],
              supportAvailability,
              (value) {
                setState(() {
                  supportAvailability = value;
                });
              },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Access()),
                    );
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
    );
  }

  Widget buildRadioTiles(
      List<String> options, int? groupValue, Function(int?) onChanged) {
    return Column(
      children: options
          .map((option) => RadioListTile<int>(
                title: Text(option),
                value: options.indexOf(option) + 1,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value),
              ))
          .toList(),
    );
  }
}
