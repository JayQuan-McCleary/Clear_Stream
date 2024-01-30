import 'package:clear_stream/Classes/bottom_nav.dart';
import 'package:clear_stream/Issues/issue_selection.dart';
import 'package:clear_stream/profile.dart';
import 'package:clear_stream/TopNavBar/my_surveys.dart';
import 'package:clear_stream/Map/map.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../Utility/checkBoxModel.dart';

void main() {

  GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CheckBoxesModel(),
      child: MaterialApp(
        home: HomePage(myMapKey: myMapKey),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  final GlobalKey<MyMapState> myMapKey;

  
  const HomePage({super.key, required this.myMapKey});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final checkBoxesModel =
        Provider.of<CheckBoxesModel>(context, listen: false);

    return Consumer<CheckBoxesModel>(
      builder: (context, checkBoxesModel, child) {
        // ignore: unused_local_variable
        final checkBoxesModel = Provider.of<CheckBoxesModel>(context);

        return Scaffold(
          appBar: null,
          body: Center(
            child: _buildBody(), // Display content based on the current index
          ),
          bottomNavigationBar: CustomBottomNavigation(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return DefaultTabController(
          length: 3, // Number of tabs (MySurveys, Assignments, Issues)
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'MySurveys'),
                  Tab(text: 'Assignments'),
                  Tab(text: 'Issues'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                // Content for each tab (MySurveys, Assignments, Issues)
                MySurveys(),

                Center(
                  child: Text('Not Available for Beta'),
                ),
                MyIssue(),
              ],
            ),
          ),
        );
      case 1:
        return const ProfilePage();
      case 2:
        return MyMap(
          mapKey: widget.myMapKey, // Access myMapKey from the widget
        );
      default:
        return const Center(
          child: Text('Invalid Tab index'),
        );
    }
  }
}
