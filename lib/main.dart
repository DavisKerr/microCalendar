import 'package:flutter/material.dart';
import 'package:micro_calendar/Screens/activity_log_screen.dart';
import 'package:micro_calendar/Screens/create_goal_screen.dart';
import 'package:micro_calendar/Screens/sign_in_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'Model/goal.dart';

import 'package:micro_calendar/Widgets/confirmation_window.dart';
import 'SpawnPopups/spawn_popups.dart';
import 'View/view_model.dart';
import 'Widgets/goal_screen.dart';
import 'Reducers/Reducer.dart';
import 'State/app_state.dart';
import 'Styles/app_themes.dart';
import 'package:micro_calendar/Widgets/track_goal_popup.dart';
import 'package:micro_calendar/Widgets/edit_delete_goal_popup.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store =
        new Store<AppState>(appStateReducer, initialState: AppState.test());
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppThemes.defaultTheme,
          home: HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  void _changeToGoalCreateScreen(BuildContext ctx)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return CreateGoalScreen();
    }));
  }

  void _changeToGoalActivityLogScreen(BuildContext ctx, Goal goal)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ActivityLogScreen(goal: goal);
    }));
  }

  void _changeToSignInScreen(BuildContext ctx)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  AppBar _buildAppBar(ViewModel viewModel, BuildContext context)
  {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () {}),
      title: const Text('Goals', style: TextStyle(fontFamily: 'OpenSans')),
      centerTitle: true, 
      actions: <Widget>[
        IconButton(icon: Icon(Icons.menu), onPressed: () {},),
        viewModel.signedIn ? 
        IconButton(icon: Icon(Icons.person), onPressed: () {}) :
        TextButton(
          child: Text("Sign In", ), 
          onPressed: () {_changeToSignInScreen(context);}, 
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        AppBar appBar = _buildAppBar(viewModel, context);
        return Scaffold(
          appBar: appBar,
          body: GoalScreen(
            maxHeight: MediaQuery.of(context).size.height - appBar.preferredSize.height,
            maxWidth: MediaQuery.of(context).size.width,
            changeToCreateGoalScreen: _changeToGoalCreateScreen,
            changeToActivityLogScreen: _changeToGoalActivityLogScreen,
          )
        );
      }
    );
  }
}



