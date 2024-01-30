// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../Utility/discardDialogue.dart';
import '../../../Utility/photoSelectionDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

// ignore: camel_case_types
class ecoli_100_NC extends StatefulWidget {
  final List<Widget> pagesToNavigate;
  final int currentIndex;
  const ecoli_100_NC({super.key, required this.pagesToNavigate, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _ecoli_100_NCState createState() => _ecoli_100_NCState();
}

// ignore: camel_case_types
class _ecoli_100_NCState extends State<ecoli_100_NC> {
  String? imageFilePath1;
  String? imageFilePath2;
  bool? _whirlPakBagChangedColor;
  // ignore: prefer_typing_uninitialized_variables
  var _selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E.coli 100-1-NC'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _greyContainer('Free and Total Chlorine Strip Test'),
              const SizedBox(height: 5),
              _nestedBulletPoint(
                  'Tear open the wrapper and remove one test strip'),
              _nestedBulletPoint(
                  'Use a cup that can hold atleast 250ml of water'),
              _nestedBulletPoint(
                  'Rinse the cup three times using the sample water'),
              _nestedBulletPoint(
                  'Fill the cup atleast 250ml with the sample water'),
              _nestedBulletPoint(
                  'Dip the end of the test strip in the water for ten seconds with a constant, gentle back and forth motion'),
              _nestedBulletPoint(
                  'Remove the strip and shake once to remove excess water'),
              _nestedBulletPoint(
                  'Wait 15 seconds then compare the color in the two pads to the card provided in the kit'),

              _nestedBulletPoint('Record the Free and total chlorine'),
              const SizedBox(height: 15),

              _greyContainer('Nitrate/Nitrite Test Strip'),
              const SizedBox(height: 5),
              _bulletPoint(
                    'Tear open the wrapper and remove atleast one test strip.'),
                _nestedBulletPoint(
                    'Use a cup that can hold atleast 50 ml of water.'),
                _nestedBulletPoint(
                    'Rinse the cup three times using the sample water'),
                _nestedBulletPoint(
                    'Fill the cup with atleast 50 ml of the sample water'),
                _nestedBulletPoint(
                    'Dip the end of the Test Strip in the water for 2 seconds with a constant, gentle back and forth motion'),
                _nestedBulletPoint(
                    'Remove the strip and shake once to remove excess water'),
                _nestedBulletPoint(
                    'Wait 60 seconds then compare the color in the two pads to the card provided in the kit'),
                _nestedBulletPoint(
                  'Record the numbers on the inner and outer Pad'
                ),
              const SizedBox(height: 15),
              
              _buildPreparationSteps(),

              // Enter the date and time that the E. coli test was STARTED
              _greyContainer(
                  'Enter the date and time that the E. coli test was STARTED'),
              const SizedBox(height: 5),

              _textField('YYYY-MM-DD hh:mm', (value) {
                setState(() {});
              }),

              // Incubate samples for 24 hours
              _greyContainer('Incubate samples for 24 hours'),
              const SizedBox(height: 5),
              _bulletPoint(
                  'Store Whirl-Pak Coli-test Bags and Compact Dry EC plates in the dark at a temperature of 37 degrees Celsius (37 C).'),
              _nestedBulletPoint(
                  'While the ideal temperature is 37 C, the test will still work at temperatures between 25 C and 40 C. Since the indoor ambient temperature in many countries is in this range, the samples can often be incubated in a dark room or cabinet.'),
              _nestedBulletPoint(
                  'The results should be read between 20 and 28 hours after the sample was processed.'),
              const SizedBox(height: 20),

              // Save form for later
              _greyContainer('Save form for later'),
              const SizedBox(height: 5),
              _bulletPoint(
                  'Finish entering any other results in this form and click the Save for Later button at the bottom of any page.'),
              _nestedBulletPoint(
                  'You will be given the opportunity to name the form. Once you click OK the form will appear in the Surveys or Tasks tab under DRAFT SURVEYS.'),
              _nestedBulletPoint(
                  'Find the draft form after the incubation period and enter the results in the next section below.'),
              const SizedBox(height: 20),

              // Results form
              _resultsForm(),

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

  Widget _buildPreparationSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _greyContainer('Prepare sample bag'),
        const SizedBox(height: 5),
        _bulletPoint('Apply hand sanitizer to your hands.'),
        _bulletPoint(
            'Find the bag labeled Whirl-Pak Coli-Test Bags and take out one bag.'),
        _bulletPoint(
            'Find the bag labeled HiE.coli Test Buds and take out one wrapped test bud.'),
        const SizedBox(height: 15),
        _greyContainer('Take sample'),
        const SizedBox(height: 5),
        _bulletPoint(
            'Remove the seal from the Whirl-Pak Coli- Test Bag by tearing along the perforated line at the top.'),
        _bulletPoint(
            'DO NOT touch the inside of the bag at any time; use the white tabs on the sides and in the middle to handle the bag.'),
        _bulletPoint(
            'Gently pull open the top of the bag using the white tabs.'),
        _nestedBulletPoint(
            'For flowing water sources, open the tap or start pumping water for at least 30 seconds before taking a sample. For standing water, simply dip the bag into the water.'),
        _bulletPoint(
            'Fill the bag to the 100 ml FILL LINE (the lower of the two lines). Pour out any excess water, but DO NOT completely pour out the sample or the chlorine-neutralizing tablet/powder will be lost.'),
        const SizedBox(height: 15),
        _greyContainer('Prepare Compact Dry Plate'),
        const SizedBox(height: 5),
        _bulletPoint(
            'Find the Compact Dry EC bag and tear open from the top. There are 4 plates in each bag.'),
        _bulletPoint(
            'Snap off one Compact Dry EC plate from the others and place it on a flat surface.'),
        _bulletPoint(
            'Use the sharpie marker to label the Compact Dry EC plate with the sample ID or mWater code from the water point.'),
        _bulletPoint(
            'Locate one disposable plastic pipette (dropper). Tear open at the large (bulb) end just enough to expose the bulb of the pipette.'),
        const SizedBox(height: 15),
        _greyContainer('Place sample in Compact Dry Plate'),
        const SizedBox(height: 5),
        _bulletPoint(
            'Pull out the pipette. ONLY touch the bulb of the pipette, not the tip.'),
        _bulletPoint(
            'Squeeze and hold the bulb, then place the tip into the Whirl-Pak Coli-Test Bag containing the water sample.'),
        _nestedBulletPoint(
            'Gently release the bulb until the water fills the pipette up to the 1ml line (the mark closest to the bulb). Hold the bulb with the same amount of pressure as you remove the tip of the pipette from the water sample.'),
        _bulletPoint(
            'Open the lid on the Compact Dry EC plate and squeeze out the pipette into the center of the plate. Replace the lid immediately.'),
        _bulletPoint(
            'Place the pipette back into the wrapper it came in and put it into the waste bag.'),
        const SizedBox(height: 15),
        _greyContainer('Add HiE.coli Test Bud to sample'),
        const SizedBox(height: 5),
        _bulletPoint(
            'Tear open the HiE.coli Test Bud without touching the inside of the package or the bud.'),
        _bulletPoint('Drop the bud into the Whirl-Pak Coli-test bag.'),
        _boldText('Seal the Whirl-Pak Coli-test bag'),
        _bulletPoint(
            'Pull the outside white tabs to close up the top of the bag.'),
        _nestedBulletPoint(
            'Holding the bag by the outside tabs, flip the bag over the tabs 3 times to seal the top of the bag.'),
        _nestedBulletPoint(
            'Fold over the white outside tabs onto themselves to keep the seal from unrolling.'),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _greyContainer(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[300],
      margin: const EdgeInsets.only(top: 16.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•'),
          const SizedBox(width: 8.0),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _nestedBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 24.0),
          const Text('•'),
          const SizedBox(width: 8.0),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _textField(String hintText, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _resultsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date and time that the E. coli results were read
        _textField(
          'Date and time results were read',
          (value) {
            setState(() {});
          },
        ),
        const SizedBox(height: 3),

        // Did the liquid in the Whirl-Pak Coli-test Bag change color from yellow to green or bluish green?
        DropdownButtonFormField<bool>(
          decoration: const InputDecoration(
            labelText:
                'Did the liquid in the Whirl-Pak Coli-test Bag change color?',
          ),
          value: _whirlPakBagChangedColor,
          onChanged: (value) {
            setState(() {
              _whirlPakBagChangedColor = value;
            });
          },
          items: const [
            DropdownMenuItem<bool>(
              value: true,
              child: Text('Yes'),
            ),
            DropdownMenuItem<bool>(
              value: false,
              child: Text('No'),
            ),
          ],
        ),
        const SizedBox(height: 20),

        const Text('Photo of Whirl-Pak bag test result'),

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
                imageFilePath1 = selectedImage;
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
            child: imageFilePath1 != null
                ? Image.file(File(imageFilePath1!))
                : const Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.black54,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 5),

        const Text(
            'How many red or purple colonies are present on the Compact Dry EC Plate?'),
        // How many red or purple colonies are present on the Compact Dry EC plate?
        _textField(
          'If more than 100 enter 101',
          (value) {
            setState(() {});
          },
        ),
        const SizedBox(height: 15),

        const Text(
            'How many blue colonies are present on the Compact Dry EC Plate?'),
        const SizedBox(height: 5),
        // How many red or purple colonies are present on the Compact Dry EC plate?
        _textField(
          'If more than 100 enter 101',
          (value) {
            setState(() {});
          },
        ),
        const SizedBox(height: 15),

        const Text('Photo of Compact Dry EC Plate'),
        const SizedBox(height: 5),

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

        const SizedBox(height: 15),

        const Text('Types of Sample'),
        Column(
          children: [
            _buildRadioTile(
                'Point of Collection', 'Sampled directly from the Water Point'),
            _buildRadioTile('Point of Consumption',
                'Container or vessel used to consume water from this source'),
            _buildRadioTile('Blank',
                'Uncontaminated source used to validate this test procedure'),
            _buildRadioTile('Duplicate',
                'Tick this box if the sample is a duplicate of a previously entered sample from the same source'),
          ],
        ),

        const Text('Date of Sample'),
        _textField('YYYY-MM-DD', (value) {
          setState(() {});
        }),
      ],
    );
  }

  Widget _buildRadioTile(String title, String subtitle) {
    return RadioListTile<String>(
      title: Text(title),
      subtitle: Text(subtitle),
      value: title,
      groupValue: _selectedPoint,
      onChanged: (value) {
        setState(() {
          _selectedPoint = value;
        });
      },
    );
  }

  Widget _boldText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '•',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // Incubation Method
          _greyContainer('Incubation Method'),
          _incubationMethodRadioTiles(),
        ],
      ),
    );
  }

  Widget _incubationMethodRadioTiles() {
    return Column(
      children: [
        _buildRadioTile('Incubator set at 37C', ''),
        _buildRadioTile('Room Temperature', ''),
      ],
    );
  }
}

