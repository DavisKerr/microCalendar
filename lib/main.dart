import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'Widgets/goal_screen.dart';
import 'Reducers/Reducer.dart';
import 'State/app_state.dart';
import 'Styles/app_themes.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Micro Calendar',
      theme: AppThemes.defaultTheme,
      home: const HomePage(),
    )
  );
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final store = Store(
      reducer,
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
        child: GoalScreen(store: store),
      )
    );
  }
}


