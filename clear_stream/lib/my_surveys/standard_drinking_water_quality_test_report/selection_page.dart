import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Indiv%20Parameters/Microbacterial%20Examination/thermo.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Indiv%20Parameters/Microbacterial%20Examination/total.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Indiv%20Parameters/inorganic.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Indiv%20Parameters/metals.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Indiv%20Parameters/physical.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Main%20Test%20Kits/ecoli-100-1-C.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Main%20Test%20Kits/ecoli-100-C.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Main%20Test%20Kits/ecoli-100-NC.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Main%20Test%20Kits/ecoli100-1-N.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Main%20Test%20Kits/ecoli100-1.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Main%20Test%20Kits/ecoli100.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Other%20Test%20Kits/comp_bag.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Other%20Test%20Kits/dry_plate.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Other%20Test%20Kits/mpn_tube.dart';
import 'package:clear_stream/my_surveys/standard_drinking_water_quality_test_report/Other%20Test%20Kits/petrifilm.dart';
import 'package:clear_stream/Utility/select_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Classes/marker_data.dart';
import '../../Utility/discardDialogue.dart';
import 'Indiv Parameters/Microbacterial Examination/ecoli.dart';
import '../../Utility/checkBoxModel.dart';

// ignore: camel_case_types
class standardDrinkingWaterQualityTest_2 extends StatefulWidget {
  final Function(Map<String, bool>) onCheckboxSelected;

  const standardDrinkingWaterQualityTest_2(
      {required Key key, required this.onCheckboxSelected})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QualState createState() => _QualState();
}

class _QualState extends State<standardDrinkingWaterQualityTest_2> {
  late CheckBoxesModel checkBoxesModel;
  List<MarkerData> facilityMarkers = [];

  bool ecoliCheckboxValue = false;
  String? ecoliType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkBoxesModel = Provider.of<CheckBoxesModel>(
        context); // Assign the value in didChangeDependencies
  }

  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  String? EcoliValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kits'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Type of Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              // Checkboxes
              CheckboxListTile(
                title: const Text('Test Kits'),
                value: checkBoxesModel.testKitsChecked,
                onChanged: (bool? value) {
                  setState(() {
                    checkBoxesModel.updateCheckboxValue(
                        'testKitsChecked', value ?? false);

                    if (!(value ?? false)) {
                      checkBoxesModel.ECOLI = '';
                    }
                  });
                },
              ),

              if (checkBoxesModel.testKitsChecked) ...[
                // Radio Buttons for Test Kit Models
                const Text(
                  'Test Kit Models',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                RadioListTile(
                    title: const Text('Ecoli100-1'),
                    subtitle: const Text('E.coli only (100ml + 1ml)'),
                    value: 'Ecoli100-1',
                    groupValue: checkBoxesModel.ECOLI,
                    onChanged: (String? selectedValue) {
                      if (selectedValue != null) {
                        setState(() {
                          checkBoxesModel.ECOLI = 'Ecoli100-1';
                        });
                      }
                    }),

                RadioListTile(
                  title: const Text('Ecoli100-1-N'),
                  subtitle:
                      const Text('E.coli only (100ml + 1ml) + Nitrate/nitrite'),
                  value: 'Ecoli100-1-N',
                  groupValue: checkBoxesModel.ECOLI,
                  onChanged: (String? value) {
                    setState(() {
                      checkBoxesModel.ECOLI = 'Ecoli100-1-N';
                    });
                  },
                ),

                RadioListTile(
                  title: const Text('Ecoli100-1-C'),
                  subtitle: const Text('E.coli (100ml + 1ml) + Free/total CI'),
                  value: 'Ecoli100-1-C',
                  groupValue: checkBoxesModel.ECOLI,
                  onChanged: (String? value) {
                    setState(() {
                      checkBoxesModel.ECOLI = 'Ecoli100-1-C';
                    });
                  },
                ),

                RadioListTile(
                  title: const Text('Ecoli100-1-NC'),
                  subtitle: const Text(
                      'E.coli (100ml + 1ml) + Nitrate/nitrite + Free/total CI'),
                  value:
                      'Ecoli100-1-NC', // This is the value you want to assign
                  groupValue: checkBoxesModel.ECOLI,
                  onChanged: (String? value) {
                    setState(() {
                      checkBoxesModel.ECOLI = 'Ecoli100-1-NC';
                    });
                  },
                ),

                RadioListTile(
                  title: const Text('Ecoli100-C'),
                  subtitle:
                      const Text('E.coli only (100ml only) + Free/total CI'),
                  value: 'Ecoli100-C',
                  groupValue: checkBoxesModel.ECOLI,
                  onChanged: (String? value) {
                    setState(() {
                      checkBoxesModel.ECOLI = 'Ecoli100-C';
                    });
                  },
                ),

                RadioListTile(
                  title: const Text('Ecoli100'),
                  subtitle: const Text('E.coli (100ml only)'),
                  value: 'Ecoli100',
                  groupValue: checkBoxesModel.ECOLI,
                  onChanged: (String? value) {
                    setState(() {
                      checkBoxesModel.ECOLI = 'Ecoli100';
                    });
                  },
                ),
              ],

              // Checkboxes for other Test Kits
              CheckboxListTile(
                title: const Text('Other Test Kits'),
                value: checkBoxesModel.otherTestKitsChecked,
                onChanged: (bool? value) {
                  setState(() {
                    checkBoxesModel.updateCheckboxValue(
                        'otherTestKitsChecked', value ?? false);

                    if (!(value ?? false)) {
                      checkBoxesModel.updateCheckboxValue('aquagenx', false);
                      checkBoxesModel.updateCheckboxValue('dryPlate', false);
                      checkBoxesModel.updateCheckboxValue('mpnTube', false);
                      checkBoxesModel.updateCheckboxValue('petrifilm', false);
                    }
                  });
                },
              ),
              if (checkBoxesModel.otherTestKitsChecked) ...[
                const Text(
                  'Select Other Test Kits',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Include checkboxes for other test kits
                // Example:

                CheckboxListTile(
                  title: const Text('Aquagenx Compartment Bag Test'),
                  value: checkBoxesModel.aquagenx,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'aquagenx', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title: const Text('Compact Dry EC Plate'),
                  value: checkBoxesModel.dryPlate,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'dryPlate', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title: const Text('Colilert MPN tube'),
                  value: checkBoxesModel.mpnTube,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'mpnTube', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title: const Text('3M Petrifilm E.coli/coliform'),
                  value: checkBoxesModel.petrifilm,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'petrifilm', value ?? false);
                    });
                  },
                ),
                // Include other CheckboxListTiles for other test kits
              ],

              // Checkboxes for Choosing Parameters Individually
              CheckboxListTile(
                title: const Text('Choose Parameters Individually'),
                value: checkBoxesModel.chooseParameterIndividuallyChecked,
                onChanged: (bool? value) {
                  setState(() {
                    checkBoxesModel.updateCheckboxValue(
                        'chooseParameterIndividuallyChecked', value ?? false);
                    if (!(value ?? false)) {
                      checkBoxesModel.updateCheckboxValue('physical', false);
                      checkBoxesModel.updateCheckboxValue('inorganic', false);
                      checkBoxesModel.updateCheckboxValue('metals', false);
                      checkBoxesModel.updateCheckboxValue(
                          'microbialExaminationChecked', false);

                      // Additionally, you can set the specific checkboxes inside MicroBiological Examination to false
                      checkBoxesModel.updateCheckboxValue('ecoli', false);
                      checkBoxesModel.updateCheckboxValue('total', false);
                      checkBoxesModel.updateCheckboxValue('thermo', false);
                      checkBoxesModel.updateCheckboxValue('enter', false);
                      checkBoxesModel.updateCheckboxValue('hpc', false);
                      checkBoxesModel.updateCheckboxValue('hs', false);
                      checkBoxesModel.updateCheckboxValue(
                          'microbialExaminationChecked', false);
                    }
                  });
                },
              ),
              if (checkBoxesModel.chooseParameterIndividuallyChecked) ...[
                const Text(
                  'Which type of Tests will you be performing',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Include checkboxes for different types of tests
                // Example:
                CheckboxListTile(
                  title: const Text('Physical and aggregate parameters'),
                  subtitle:
                      const Text('pH, turbidity, TDS, alkalinity, salinity'),
                  value: checkBoxesModel.physical,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'physical', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title: const Text('Inorganic Chemicals'),
                  subtitle:
                      const Text('fluoride, nitrate, phosphate, chloride'),
                  value: checkBoxesModel.inorganic,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'inorganic', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title: const Text('Metals'),
                  subtitle: const Text('arsenic, iron, aluminum, etc.'),
                  value: checkBoxesModel.metals,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'metals', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title: const Text('MicroBiological Examination'),
                  subtitle:
                      const Text('pH, turbidity, TDS, alkalinity, salinity'),
                  value: checkBoxesModel.microbialExaminationChecked,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'microbialExaminationChecked', value ?? false);

                      if (!(value ?? false)) {
                        checkBoxesModel.updateCheckboxValue('ecoli', false);
                        checkBoxesModel.updateCheckboxValue('total', false);
                        checkBoxesModel.updateCheckboxValue('thermo', false);
                      }
                    });
                  },
                ),
                // Include other CheckboxListTiles for different types of tests
              ],

              if (checkBoxesModel.microbialExaminationChecked) ...[
                const Text(
                  'E.coli',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Include checkboxes for E.coli tests
                // Example:
                CheckboxListTile(
                  title: const Text('E.coli'),
                  subtitle: const Text(
                      'Enzymatic or Defined Substrate Test specific to E.coli only - 37C incubation'),
                  value: checkBoxesModel.ecoli,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'ecoli', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title: const Text('Total Coliform'),
                  subtitle: const Text(
                      'Enzymatic or Defined Substrate Test for Total Coliforms - 37C incubation'),
                  value: checkBoxesModel.total,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'total', value ?? false);
                    });
                  },
                ),

                CheckboxListTile(
                  title:
                      const Text('Thermotolerant Coliform (Faecal Coliform)'),
                  subtitle: const Text(
                      'General test for Coliforms - 44C incubation temperature'),
                  value: checkBoxesModel.thermo,
                  onChanged: (value) {
                    setState(() {
                      checkBoxesModel.updateCheckboxValue(
                          'thermo', value ?? false);
                    });
                  },
                ),
              ],

              // Buttons
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
                    onPressed: () {
                      List<Widget> pagesToNavigate = [];

                      if (checkBoxesModel.ECOLI == 'Ecoli100-1') {
                        pagesToNavigate.add(Ecoli100_1(
                          currentIndex: pagesToNavigate.length,
                          pagesToNavigate: pagesToNavigate,
                        ));
                      }

                      if (checkBoxesModel.ECOLI == 'Ecoli100-1-N') {
                        pagesToNavigate.add(Ecoli100_1_N(
                          currentIndex: pagesToNavigate.length,
                          pagesToNavigate: pagesToNavigate,
                        ));
                      }

                      if (checkBoxesModel.ECOLI == 'Ecoli100-1-C') {
                        pagesToNavigate.add(Ecoli_100_1_C(
                          pagesToNavigate: pagesToNavigate,
                          currentIndex: pagesToNavigate.length,
                        ));
                      }

                      if (checkBoxesModel.ECOLI == 'Ecoli100-1-NC') {
                        pagesToNavigate.add(ecoli_100_NC(
                          pagesToNavigate: pagesToNavigate,
                          currentIndex: pagesToNavigate.length,
                        ));
                      }

                      if (checkBoxesModel.ECOLI == 'Ecoli100-C') {
                        pagesToNavigate.add(ecoli_100_C(
                          pagesToNavigate: pagesToNavigate,
                          currentIndex: pagesToNavigate.length,
                        ));
                      }

                      if (checkBoxesModel.ECOLI == 'Ecoli100') {
                        pagesToNavigate.add(ecoli100(
                          pagesToNavigate: pagesToNavigate,
                          currentIndex: pagesToNavigate.length,
                        ));
                      }

                      if (checkBoxesModel.aquagenx) {
                        pagesToNavigate.add(AquagenXCompartmentBagTest(
                          pagesToNavigate: pagesToNavigate,
                          currentIndex: pagesToNavigate.length,
                        ));
                      }

                      if (checkBoxesModel.dryPlate) {
                        pagesToNavigate.add(CompactDryECPlate(
                          pagesToNavigate: pagesToNavigate,
                          currentIndex: pagesToNavigate.length,
                        ));
                      }

                      if (checkBoxesModel.mpnTube) {
                        pagesToNavigate.add(MPN(
                          pagesToNavigate: pagesToNavigate,
                          currentIndex: pagesToNavigate.length,
                        ));
                      }
                      if (checkBoxesModel.petrifilm) {
                        pagesToNavigate.add(Petrifilm(
                            pagesToNavigate: pagesToNavigate,
                            currentIndex: pagesToNavigate.length));
                      }

                      if (checkBoxesModel.physical) {
                        pagesToNavigate.add(PhysicalAndAggregateParametersForm(
                            pagesToNavigate: pagesToNavigate,
                            currentIndex: pagesToNavigate.length));
                      }

                      if (checkBoxesModel.inorganic) {
                        pagesToNavigate.add(InorganicChemicals(
                            currentIndex: pagesToNavigate.length,
                            pagesToNavigate: pagesToNavigate));
                      }

                      if (checkBoxesModel.metals) {
                        pagesToNavigate.add(Metals(
                            currentIndex: pagesToNavigate.length,
                            pagesToNavigate: pagesToNavigate));
                      }

                      if (checkBoxesModel.ecoli) {
                        pagesToNavigate.add(EColitestingForm(
                            currentIndex: pagesToNavigate.length,
                            pagesToNavigate: pagesToNavigate));
                      }

                      if (checkBoxesModel.total) {
                        pagesToNavigate.add(TotalColiform(
                            currentIndex: pagesToNavigate.length,
                            pagesToNavigate: pagesToNavigate));
                      }

                      if (checkBoxesModel.thermo) {
                        pagesToNavigate.add(Thermo(
                            currentIndex: pagesToNavigate.length,
                            pagesToNavigate: pagesToNavigate));
                      }

                      if (pagesToNavigate.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pagesToNavigate.first),
                        );
                      } else {
                        if (pagesToNavigate.isEmpty) {
                          showCustomToast('Please Select an Option');
                        }
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
            ]),
          ),
        ));
  }
}
