// ignore_for_file: file_names

import 'package:clear_stream/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Classes/marker_data.dart';
import '../Map/map.dart';

// ignore: must_be_immutable
class DiscardSurveyDialog extends StatelessWidget {
  DiscardSurveyDialog({super.key});

  GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();
  List<MarkerData> facilityMarkers = [];

  void didChangeDependencies() {
    MyMap myMap = MyMap(
      mapKey: myMapKey,
    );
    facilityMarkers = myMap.getAvailableMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Discard Survey'),
      content: const Text('Do you wish to discard the survey?'),
      actions: [
        TextButton(
          onPressed: () {
            // Handle "No" action
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            // Use Navigator to push the HomeScreen route
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
            // Show toast message
            Fluttertoast.showToast(
              msg: 'Survey Discarded',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 14.0,
            );

            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
