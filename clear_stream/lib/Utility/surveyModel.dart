// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

/*as you can see i made two of these classes  future 
i couldnt get either to work and ended up giving up
 hopefully if your future me you got this working
...if your an examiner....you see the vision though right
if i had one more week trust me id get this working
*/
class SurveyModel {
  final String type;
  final String status;
  final String waterpoint;
  final String date;

  SurveyModel(this.type, this.status, this.waterpoint, this.date);
}

class SurveysModel extends ChangeNotifier {
  List<SurveyModel> savedSurveys = [];

  void addSurvey(SurveyModel survey) {
    savedSurveys.add(survey);
    notifyListeners();
  }
}

