// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import '../../../Utility/discardDialogue.dart';
import '../../../Utility/select_toast.dart';
import '../../../Utility/sumbitDialogueBox.dart';

class PhysicalAndAggregateParametersForm extends StatefulWidget {
  final List<Widget> pagesToNavigate;
  final int currentIndex;

  const PhysicalAndAggregateParametersForm(
      {super.key, required this.pagesToNavigate, required this.currentIndex});

  @override
  State<PhysicalAndAggregateParametersForm> createState() =>
      _PhysicalAndAggregateParametersFormState();
}

class _PhysicalAndAggregateParametersFormState
    extends State<PhysicalAndAggregateParametersForm> {
  String selectedUnit = 'NTU';
  String selectedMethod = 'No Option';
  bool _freeChlorineResidualChecked = false;
  double _freeChlorineResidualValue = 0.0;
  String _freeChlorineResidualUnit = 'mg/L';
  String _freeChlorineResidualMethod = '';

  bool _combinedTotalChlorineResidualChecked = false;
  double _combinedTotalChlorineResidualValue = 0.0;
  String _combinedTotalChlorineResidualUnit = 'mg/L';
  String _combinedTotalChlorineResidualMethod = '';

  bool _phChecked = false;
  double _phValue = 0.0;
  String _phMethod = 'noOption';

  bool _turbidityChecked = false;
  double _turbidityValue = 0.0;
  String _turbidityUnit = 'NTU';
  String _turbidityMethod = 'blank';

  bool _tdsChecked = false;
  double _tdsValue = 0.0;
  String _tdsUnit = 'ppm';
  String _tdsMethod = 'blank';

  bool _hardnessChecked = false;
  double _hardnessValue = 0.0;

  bool _alkalinityChecked = false;
  double _alkalinityValue = 0.0;

  bool _electricalConductivityChecked = false;
  final String _electricalConductivityUnit =
      'hS/cm'; // Replace with the default unit you want to set
  double _electricalConductivityValue = 0.0;

  bool _salinityChecked = false;
  final String _salinityValue =
      'PSU'; // Replace with the default unit you want to set

  double _salinityValueNum = 0.0;

  bool _temperatureChecked = false;
  final String _temperatureValue =
      'C'; // Replace with the default unit you want to set

  double _temperatureValueNum = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Physical and Aggregate Parameters'),
          automaticallyImplyLeading: false, // Set this to false to remove the back button
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          CheckboxListTile(
            title: const Text('Free Chlorine Residual'),
            value: _freeChlorineResidualChecked,
            onChanged: (value) =>
                setState(() => _freeChlorineResidualChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_freeChlorineResidualChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Free Chlorine Residual Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(() =>
                          _freeChlorineResidualValue = double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _freeChlorineResidualUnit,
                    onChanged: (value) =>
                        setState(() => _freeChlorineResidualUnit = value!),
                    items: const [
                      DropdownMenuItem(
                        value: 'mg/L',
                        child: Text('mg/L'),
                      ),
                      DropdownMenuItem(
                        value: 'ppm',
                        child: Text('ppm'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (_freeChlorineResidualChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Free Chlorine Residual Method',
                ),
                onChanged: (value) =>
                    setState(() => _freeChlorineResidualMethod = value),
              ),
            ),
          CheckboxListTile(
            title: const Text('Combined Total Chlorine Residual'),
            value: _combinedTotalChlorineResidualChecked,
            onChanged: (value) =>
                setState(() => _combinedTotalChlorineResidualChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_combinedTotalChlorineResidualChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Combined Total Chlorine Residual Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(() =>
                          _combinedTotalChlorineResidualValue =
                              double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _combinedTotalChlorineResidualUnit,
                    onChanged: (value) => setState(
                        () => _combinedTotalChlorineResidualUnit = value!),
                    items: const [
                      DropdownMenuItem(
                        value: 'mg/L',
                        child: Text('mg/L'),
                      ),
                      DropdownMenuItem(
                        value: 'ppm',
                        child: Text('ppm'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (_combinedTotalChlorineResidualChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Combined Total Chlorine Residual Method',
                ),
                onChanged: (value) => setState(
                    () => _combinedTotalChlorineResidualMethod = value),
              ),
            ),

          CheckboxListTile(
            title: const Text('pH'),
            value: _phChecked,
            onChanged: (value) => setState(() => _phChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_phChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'pH Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => _phValue = double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _phMethod,
                    onChanged: (value) => setState(() => _phMethod = value!),
                    items: const [
                      DropdownMenuItem(
                        value: 'noOption',
                        child: Text('No method'),
                      ),
                      DropdownMenuItem(
                        value: 'testStrip',
                        child: Text('Test Strip'),
                      ),
                      DropdownMenuItem(
                        value: 'electrodeProbe',
                        child: Text('Electrode/Probe'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          CheckboxListTile(
            title: const Text('Turbidity'),
            value: _turbidityChecked,
            onChanged: (value) => setState(() => _turbidityChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_turbidityChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Turbidity Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => _turbidityValue = double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _turbidityUnit,
                    onChanged: (value) =>
                        setState(() => _turbidityUnit = value!),
                    items: const [
                      DropdownMenuItem(
                        value: 'NTU',
                        child: Text('NTU'),
                      ),
                      DropdownMenuItem(
                        value: 'JTU',
                        child: Text('JTU'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (_turbidityChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: _turbidityMethod,
                onChanged: (value) => setState(() => _turbidityMethod = value!),
                items: const [
                  DropdownMenuItem(
                    value: 'blank',
                    child: Text('Blank'),
                  ),
                  DropdownMenuItem(
                    value: 'turbidimeter',
                    child: Text('Turbidimeter (Electronic Nephelometer)'),
                  ),
                  DropdownMenuItem(
                    value: 'turbidityTube',
                    child: Text('Turbidity Tube'),
                  ),
                ],
              ),
            ),

          CheckboxListTile(
            title: const Text('Total Dissolved Solids'),
            value: _tdsChecked,
            onChanged: (value) => setState(() => _tdsChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_tdsChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Total Dissolved Solids Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => _tdsValue = double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _tdsUnit,
                    onChanged: (value) => setState(() => _tdsUnit = value!),
                    items: const [
                      DropdownMenuItem(
                        value: 'ppm',
                        child: Text('ppm'),
                      ),
                      DropdownMenuItem(
                        value: 'mg/L',
                        child: Text('mg/L'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (_tdsChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: _tdsMethod,
                onChanged: (value) => setState(() => _tdsMethod = value!),
                items: const [
                  DropdownMenuItem(
                    value: 'blank',
                    child: Text('Blank'),
                  ),
                  DropdownMenuItem(
                    value: 'tdsMeter',
                    child: Text('TDS Meter'),
                  ),
                  DropdownMenuItem(
                    value: 'testStrip',
                    child: Text('Test Strip'),
                  ),
                  DropdownMenuItem(
                    value: 'electricalConductivityMeter',
                    child: Text('Electrical Conductivity Meter'),
                  ),
                ],
              ),
            ),
// ... (previous code)

          CheckboxListTile(
            title: const Text('Hardness'),
            value: _hardnessChecked,
            onChanged: (value) => setState(() => _hardnessChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_hardnessChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Hardness Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => _hardnessValue = double.parse(value)),
                    ),
                  ),
                ],
              ),
            ),

          CheckboxListTile(
            title: const Text('Alkalinity'),
            value: _alkalinityChecked,
            onChanged: (value) => setState(() => _alkalinityChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_alkalinityChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Alkalinity Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(
                          () => _alkalinityValue = double.parse(value)),
                    ),
                  ),
                ],
              ),
            ),

          CheckboxListTile(
            title: const Text('Electrical Conductivity'),
            value: _electricalConductivityChecked,
            onChanged: (value) =>
                setState(() => _electricalConductivityChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_electricalConductivityChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Electrical Conductivity Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(() =>
                          _electricalConductivityValue = double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _electricalConductivityUnit,
                    onChanged: (value) => setState(
                        () => _electricalConductivityValue = value! as double),
                    items: const [
                      DropdownMenuItem(
                        value: 'hS/cm',
                        child: Text('hS/cm'),
                      ),
                      DropdownMenuItem(
                        value: 'mS/cm',
                        child: Text('mS/cm'),
                      ),
                      DropdownMenuItem(
                        value: 'hmho/cm',
                        child: Text('hmho/cm'),
                      ),
                      DropdownMenuItem(
                        value: 'mmho/cm',
                        child: Text('mmho/cm'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          CheckboxListTile(
            title: const Text('Salinity'),
            value: _salinityChecked,
            onChanged: (value) => setState(() => _salinityChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_salinityChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Salinity Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(
                          () => _salinityValueNum = double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _salinityValue,
                    onChanged: (value) =>
                        setState(() => _salinityValueNum = value! as double),
                    items: const [
                      DropdownMenuItem(
                        value: 'PSU',
                        child: Text('PSU'),
                      ),
                      DropdownMenuItem(
                        value: 'ppt',
                        child: Text('ppt'),
                      ),
                      DropdownMenuItem(
                        value: 'g/kg',
                        child: Text('g/kg'),
                      ),
                      DropdownMenuItem(
                        value: 'mg/L',
                        child: Text('mg/L'),
                      ),
                      DropdownMenuItem(
                        value: 'uS/cm',
                        child: Text('uS/cm'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          CheckboxListTile(
            title: const Text('Temperature'),
            value: _temperatureChecked,
            onChanged: (value) => setState(() => _temperatureChecked = value!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_temperatureChecked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Temperature Value',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(
                          () => _temperatureValueNum = double.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _temperatureValue,
                    onChanged: (value) =>
                        setState(() => _temperatureValueNum = value! as double),
                    items: const [
                      DropdownMenuItem(
                        value: 'C',
                        child: Text('C'),
                      ),
                      DropdownMenuItem(
                        value: 'F',
                        child: Text('F'),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            

          // Navigation Buttons
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
                onPressed: () async {
                  // Action for 'Next' button
                  if (widget.currentIndex + 1 < widget.pagesToNavigate.length) {
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
                child: const Text('Discard', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ])));
  }
}
