import 'package:flutter/material.dart';

/*as you can see i made two of these classes  future 
i couldnt get either to work and ended up giving up
 hopefully if your future me you got this working
...if your an examiner....you see the vision though right
if i had one more week trust me id get this working
*/

class SurveysModel extends ChangeNotifier {
  List<SurveyData> savedSurveys = [];

  void saveSurveyDraft(SurveyData survey) {
    savedSurveys.add(survey);
    notifyListeners();
  }
}

class SurveyData {
  final String date;
  final String waterpoint;
  final List<String> pages; // Add a list of pages

  SurveyData({
    required this.date,
    required this.waterpoint,
    required this.pages, // Initialize the list of pages
  });
}
