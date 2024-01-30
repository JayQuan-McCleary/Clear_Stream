import 'package:clear_stream/Issues/Issue%20Pages/asset.dart';
import 'package:clear_stream/Issues/Issue%20Pages/downtime.dart';
import 'package:clear_stream/Issues/Issue%20Pages/health_facility.dart';
import 'package:clear_stream/Issues/Issue%20Pages/water_point.dart';
import 'package:flutter/material.dart';


class MyIssue extends StatelessWidget {
  const MyIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text(
                'Issues',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              value: null, // Set the value based on selection
              onChanged: (String? value) {
                if (value == 'Water Point functionality issue') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WaterpointFunctionality(),
                    ),
                  );
                } else if (value == 'Health Facility functionality issue') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const HealthFacilityIssueForm(),
                    ),
                  );
                } else if (value == 'Asset issue') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Asset(),
                    ),
                  );
                } else if (value == 'Water Point Downtime issue') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WaterPointDowntime(),
                    ),
                  );
                }
              },
              items: const [
                DropdownMenuItem(
                  value: 'Water Point functionality issue',
                  child: Text('Water Point functionality issue'),
                ),
                DropdownMenuItem(
                  value: 'Health Facility functionality issue',
                  child: Text('Health Facility functionality issue'),
                ),
                DropdownMenuItem(
                  value: 'Asset issue',
                  child: Text('Asset issue'),
                ),
                DropdownMenuItem(
                  value: 'Water Point Downtime issue',
                  child: Text('Water Point Downtime issue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
