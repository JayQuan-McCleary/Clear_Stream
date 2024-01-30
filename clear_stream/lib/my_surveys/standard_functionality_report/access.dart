import 'package:clear_stream/Utility/select_toast.dart';
import 'package:clear_stream/Utility/sumbitDialogueBox.dart';
import 'package:flutter/material.dart';
import '../../Utility/discardDialogue.dart';

class Access extends StatefulWidget {
  const Access({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccessState createState() => _AccessState();
}

class _AccessState extends State<Access> {
  TextEditingController commentsController =
      TextEditingController(); // Controller for the TextField

  int? numberOfPersonsRadioValue;
  int? numberOfHouseholdsRadioValue;
  int? sourceOfInformationRadioValue;
  int? community;

  double? numberOfPersons;
  double? totalNumberOfHouseholds;
  double? numberOfPeoplePerHousehold;

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQuery.of(context).size.width * 0.95; // Set width using MediaQuery

    return Scaffold(
      appBar: AppBar(
        title: const Text('Access'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Ask the respondents if there are records available to determine how many persons or households regularly use this water point. If records are not available, ask if it is possible to estimate the number?',
              style: TextStyle(fontSize: 18),
            ),
            buildRadioTiles(
              [
                'Enter the number of Persons',
                'Enter the number of Households',
                'Enter both Persons and Households',
                'Cannot Estimate number of users',
              ],
              numberOfPersonsRadioValue,
              (value) {
                setState(() {
                  numberOfPersonsRadioValue = value;
                });
              },
            ),
            if (numberOfPersonsRadioValue == 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Number of persons (including all household members) who regularly use the waterpoint',
                    style: TextStyle(fontSize: 18),
                  ),
                  const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter number',
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildSourceOfInformationQuestions(),
                ],
              ),
            if (numberOfPersonsRadioValue == 2)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. Total number of households who regularly use the waterpoint',
                    style: TextStyle(fontSize: 18),
                  ),
                  const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter number',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '2. Number of people per household (optional) - Used to calculate the number of persons when only the number of households is known. This can be a decimal number (e.g. 5.3)',
                    style: TextStyle(fontSize: 18),
                  ),
                  const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter number',
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildSourceOfInformationQuestions(),
                ],
              ),
            if (numberOfPersonsRadioValue == 3)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  '1. Number of persons (including all household members) who regularly use the waterpoint',
                  style: TextStyle(fontSize: 18),
                ),
                const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '2. Total number of households who regularly use the water point',
                  style: TextStyle(fontSize: 18),
                ),
                const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                  ),
                ),
                const SizedBox(height: 20),
                buildSourceOfInformationQuestions(),
              ]),
            const SizedBox(height: 20),
            const Text(
              'Is everyone in the community able to access the water point? - Please record in the comments who is not able to access the Water Point and why, for example is it due to their caste, disability, lack of money, or culture and beliefs?',
              style: TextStyle(fontSize: 18),
            ),
            buildRadioTiles2(
              ['Yes', 'No'],
              community,
              (value) {
                setState(() {
                  community = value;
                });
              },
            ),

            // New TextField for comments
            const SizedBox(height: 20),
            SizedBox(
              width: width,
              child: TextField(
                controller: commentsController,
                maxLines: 2, // Set max lines based on your requirement
                decoration: InputDecoration(
                  hintText: 'Comments',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
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
                      // ignore: unused_local_variable
                      bool submitSurvey = await showDialog(
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
    );
  }

  Widget buildRadioTiles(
      List<String> options, int? groupValue, Function(int?) onChanged) {
    return Column(
      children: options
          .map((option) => RadioListTile<int>(
                title: Text(option.endsWith('?') ? option : '$option?',
                    style: const TextStyle(fontSize: 18)),
                value: options.indexOf(option) + 1,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value),
              ))
          .toList(),
    );
  }

  Widget buildRadioTiles2(
      List<String> options, int? groupValue, Function(int?) onChanged) {
    return Column(
      children: options
          .map((option) => RadioListTile<int>(
                title: Text(option.endsWith('') ? option : '$option?',
                    style: const TextStyle(fontSize: 18)),
                value: options.indexOf(option) + 1,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value),
              ))
          .toList(),
    );
  }

  Widget buildSourceOfInformationQuestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What was the source of information for the number of users or households?',
          style: TextStyle(fontSize: 18),
        ),
        buildRadioTiles(
          [
            'From Records - Listing of users or household kept by Water User Committee or Service Provider',
            'From Survey - Results from a recent survey of users within the catchment area',
            'Estimated - From census data, maps, or local government representatives',
          ],
          sourceOfInformationRadioValue,
          (value) {
            setState(() {
              sourceOfInformationRadioValue = value;
            });
          },
        ),
      ],
    );
  }
}
