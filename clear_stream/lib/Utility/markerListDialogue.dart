// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MarkerListDialog extends StatelessWidget {
  final List<String> markerNames;
  final Function(String) onMarkerSelected;

  const MarkerListDialog({
    super.key,
    required this.markerNames,
    required this.onMarkerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Marker'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            for (String markerName in markerNames)
              ListTile(
                title: Text(markerName),
                onTap: () {
                  onMarkerSelected(markerName);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
