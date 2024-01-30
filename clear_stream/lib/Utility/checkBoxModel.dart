// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';

class CheckBoxesModel extends ChangeNotifier {
  bool testKitsChecked = false;
  bool otherTestKitsChecked = false;
  bool hideInstructions = false;
  bool physicalParametersChecked = false;
  bool chooseParameterIndividuallyChecked = false;
  bool microbialExaminationChecked = false;
  bool dryPlate = false;
  bool mpnTube = false;
  bool petrifilm = false;
  bool inorganic = false;
  bool metals = false;
  bool ecoli = false;
  bool ecoliBool = false;
  bool hpc = false;
  bool hs = false;
  bool coliform = false;
  bool thermo = false;
  bool enter = false;
  bool aquagenx = false;
  bool physical = false;
  bool total = false;
  String ECOLI = '';

  void updateCheckboxValue(String checkboxName, bool value) {
    print('Updating checkbox: $checkboxName with value: $value');

    switch (checkboxName) {
      case 'testKitsChecked':
        testKitsChecked = value;
        break;
      case 'otherTestKitsChecked':
        otherTestKitsChecked = value;
        break;
      case 'hideInstructions':
        hideInstructions = value;
        break;
      case 'physicalParametersChecked':
        physicalParametersChecked = value;
        break;
      case 'chooseParameterIndividuallyChecked':
        chooseParameterIndividuallyChecked = value;
        break;
      case 'microbialExaminationChecked':
        microbialExaminationChecked = value;
        break;
      case 'dryPlate':
        dryPlate = value;
        break;
      case 'mpnTube':
        mpnTube = value;
        break;
      case 'petrifilm':
        petrifilm = value;
        break;
      case 'inorganic':
        inorganic = value;
        break;
      case 'metals':
        metals = value;
        break;
      case 'ecoli':
        ecoli = value;
        break;
      case 'hpc':
        hpc = value;
        break;
      case 'hs':
        hs = value;
        break;
      case 'coliform':
        coliform = value;
        break;
      case 'thermo':
        thermo = value;
        break;
      case 'enter':
        enter = value;
        break;
      case 'aquagenx':
        aquagenx = value;
        break;
      case 'physical':
        physical = value;
        break;
      case 'Ecoli100':
        ECOLI = '';
        break;
      case 'total':
        total = value;
        break;
      default:
        throw Exception('Invalid checkbox name: $checkboxName');
    }
    notifyListeners();
  }
}
