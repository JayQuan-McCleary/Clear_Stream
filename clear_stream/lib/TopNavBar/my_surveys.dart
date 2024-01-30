import 'package:clear_stream/my_surveys/stadard_sanitary_inspections/main_list.dart';
import 'package:clear_stream/Utility/surveyModel.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/welcome_page.dart';
import 'package:clear_stream/my_surveys/standard_functionality_report/standard_functionality_report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySurveys extends StatelessWidget {
  const MySurveys({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SurveysModel(),
      child: Scaffold(
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text(
                  'Start Survey',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                value: null, // Set the value based on selection
                onChanged: (String? value) {
                  if (value == 'Standard Functionality Report') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const StandardFunctionalityReport()),
                    );
                  } else if (value ==
                      'Standard Drinking Water Quality Test Report') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const StandardDrinkingWaterQualityTest()),
                    );
                  } else if (value == 'Standard Sanitary Inspection') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WaterPointInfo()),
                    );
                  }
                },

                items: const [
                  DropdownMenuItem(
                    value: 'Standard Functionality Report',
                    child: Text('Standard Functionality Report'),
                  ),
                  DropdownMenuItem(
                    value: 'Standard Drinking Water Quality Test Report',
                    child: Text('Standard Drinking Water Quality Test Report'),
                  ),
                  DropdownMenuItem(
                    value: 'Standard Sanitary Inspection',
                    child: Text('Standard Sanitary Inspection'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Surveys',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Replace this with your logic to display drafted, rejected, and completed surveys
              // For example:
              ListView(
                shrinkWrap: true,
                children: [
                  const ListTile(
                    title: Text(
                      'Drafted Survey',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  Consumer<SurveysModel>(
                    builder: (context, surveysModel, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: surveysModel.savedSurveys.length,
                        itemBuilder: (context, index) {
                          final survey = surveysModel.savedSurveys[index];
                          return ListTile(
                            title: Text(
                              '${survey.waterpoint} - ${survey.type}',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              // Navigate to a screen where the user can view/edit the selected survey
                              //Most Likely I'm gona have to scrap out of time
                            },
                          );
                        },
                      );
                    },
                  ),
                  const ListTile(
                    title: Text(
                      'Rejected Survey',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  const ListTile(
                    title: Text(
                      'Recently Completed Survey',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
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
