// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Map/map.dart';
import '../StartUp/homepage.dart';

class SubmitSurveyDialog extends StatelessWidget {
   SubmitSurveyDialog({super.key});
   
final GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Submit Survey'),
      content: const Text('Would you like to submit this survey?'),
      actions: [
        TextButton(
          onPressed: () async {
            // Show a confirmation snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Survey not submitted. Reasons: Beta'),
                duration: Duration(seconds: 3),
              ),
            );

            // Close the dialog and return true
            Navigator.of(context).pop(true);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  HomePage(myMapKey: myMapKey,)),
            );
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            // Handle "No" action
            Navigator.of(context).pop(false); // Close the dialog and return false
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
