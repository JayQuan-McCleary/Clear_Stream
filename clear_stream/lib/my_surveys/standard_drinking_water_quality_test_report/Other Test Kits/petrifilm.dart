import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Utility/checkBoxModel.dart';
import '../../../Utility/discardDialogue.dart';
import '../../../Utility/photoSelectionDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class Petrifilm extends StatefulWidget {
  final List<Widget> pagesToNavigate;
  final int currentIndex;

  const Petrifilm(
      {super.key, required this.pagesToNavigate, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _PetrifilmState createState() => _PetrifilmState();
}

class _PetrifilmState extends State<Petrifilm> {

  String? imageFilePath;
  String? imageFilePath2;


  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final CheckBoxesModel checkBoxesModel =
        Provider.of<CheckBoxesModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('3M Petrifilm'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Widget
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Enter the Compartment Bag Test Results by Clicking on Record',
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
        
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Number of Blue Colonies with Gas Bubbles (E.coli)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'With more than 100, please enter 101',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Number of Red Colonies with Gas Bubbles (Other total Coliform)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'With more than 100, please enter 101',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      // You can handle the input and store the value as needed
                      // onChanged: (value) {
                      //   // Handle the value entered by the user
                      // },
                    ),
                  ),
                  const SizedBox(height: 20),
        
                    const Text(
                    'Number of Red Colonies with NO Gas Bubbles (gram negative non-coliform)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'With more than 100, please enter 101',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      // You can handle the input and store the value as needed
                      // onChanged: (value) {
                      //   // Handle the value entered by the user
                      // },
                    ),
                  ),
                  const SizedBox(height: 20),                
                  const Text(
                    'Photo of Petrifilm Test',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
            //end copy
            
            const Text(
              'Record',
              style: TextStyle(
                fontSize: 15,
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
              ),
            ),

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
                imageFilePath2 = selectedImage;
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
            child: imageFilePath2 != null
                ? Image.file(File(imageFilePath2!))
                : const Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.black54,
                    ),
                  ),
          ),
        ),

            //start copy

                ],
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
        ),
      ),
    );
  }
}
