import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Utility/checkBoxModel.dart';
import '../../../Utility/discardDialogue.dart';
import '../../../Utility/photoSelectionDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class MPN extends StatefulWidget {
  final List<Widget> pagesToNavigate;
  final int currentIndex;

  const MPN({
    super.key,
    required this.pagesToNavigate,
    required this.currentIndex,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MPNState createState() => _MPNState();
}

class _MPNState extends State<MPN> {

  String? imageFilePath;

  // Variables and states
  bool sampleYellow = false; // state to keep track of the radio button selection
  bool sampleBluish = false; // state to keep track of the radio button selection

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final CheckBoxesModel checkBoxesModel = Provider.of<CheckBoxesModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MPN Tube'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text to enter results
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Enter the Compartment Bag Test Results',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            const SizedBox(height: 5),
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

            const SizedBox(height: 20),
            // Questions about the sample
            const Text(
              'Did the sample change color to yellow (total coliform positive)?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            RadioListTile<bool>(
              title: const Text('Yes'),
              value: true,
              groupValue: sampleYellow,
              onChanged: (bool? value) {
                setState(() {
                  sampleYellow = value!;
                });
              },
            ),
            RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: sampleYellow,
              onChanged: (bool? value) {
                setState(() {
                  sampleYellow = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Did the sample produce a bluish color under UV light (E.coli positive)?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            RadioListTile<bool>(
              title: const Text('Yes'),
              value: true,
              groupValue: sampleBluish,
              onChanged: (bool? value) {
                setState(() {
                  sampleBluish = value!;
                });
              },
            ),
            RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: sampleBluish,
              onChanged: (bool? value) {
                setState(() {
                  sampleBluish = value!;
                });
              },
            ),

            const SizedBox(height: 10,),

            // Navigation Buttons
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
      ),
    );
  }
}
