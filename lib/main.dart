import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'Model/goal.dart';

import 'package:micro_calendar/Widgets/confirmation_window.dart';
import 'Widgets/goal_screen.dart';
import 'Reducers/Reducer.dart';
import 'State/app_state.dart';
import 'Styles/app_themes.dart';
import 'package:micro_calendar/Widgets/track_goal_popup.dart';
import 'package:micro_calendar/Widgets/edit_delete_goal_popup.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Micro Calendar',
      theme: AppThemes.defaultTheme,
      home: const HomePage(),
    )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _startGoalTracker(BuildContext ctx, Store store, Goal goal) {
    showDialog(context: context,
      builder: (BuildContext context) {
        return TrackGoalPopup(store: store, goal: goal);
    });
  }

  void _startGoalEditor(BuildContext ctx, Store store, Goal goal) {
    showDialog(context: context,
      builder: (BuildContext context) {
        return EditDeleteGoalPopup(store: store, goal: goal);
    });
  }



  @override
  Widget build(BuildContext context) {
    final store = Store(
      appStateReducer,
      initialState: const AppState.test(),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () {}),
        title: const Text('Calendar Name', style: TextStyle(fontFamily: 'OpenSans')),
        centerTitle: true, 
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu), onPressed: () {},),
          IconButton(icon: Icon(Icons.arrow_right), onPressed: () {}),
        ],
      ),
      body: StoreProvider(
        store: store,
        child: GoalScreen(store: store, trackGoalFunction: _startGoalTracker, editGoalFunction: _startGoalEditor,),
      )
    );
  }
}



