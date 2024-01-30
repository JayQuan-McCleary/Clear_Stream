import 'dart:io';
import 'package:clear_stream/Utility/sumbitDialogueBox.dart';
import 'package:flutter/material.dart';
import '../../../Utility/discardDialogue.dart';
import '../../../Utility/photoSelectionDialogue.dart';
import '../../../Utility/select_toast.dart';

class AquagenXCompartmentBagTest extends StatefulWidget {
  final List<Widget> pagesToNavigate;
  final int currentIndex;

  const AquagenXCompartmentBagTest({
    super.key,
    required this.pagesToNavigate,
    required this.currentIndex,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AquagenXCompartmentBagTestState createState() =>
      _AquagenXCompartmentBagTestState();
}

class _AquagenXCompartmentBagTestState
    extends State<AquagenXCompartmentBagTest> {
  String? imageFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AquagenX Compartment Bag Test'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Widget
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
                  child: const Text('Discard', style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
