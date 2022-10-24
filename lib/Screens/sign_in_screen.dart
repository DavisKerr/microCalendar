import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';
import 'package:micro_calendar/Widgets/progress_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';
import '../View/view_model.dart';


class SignInScreen extends StatelessWidget {

  const SignInScreen();

  void _backToGoalScreen(BuildContext context)
  {
    // TODO: Add a confirmation window here. 
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    AppBar appBar = AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () => _backToGoalScreen(context)),
      title: const Text('Calendar Name', style: TextStyle(fontFamily: 'OpenSans')),
      centerTitle: true, 
      actions: <Widget>[
        IconButton(icon: Icon(Icons.menu), onPressed: () {},),
      ],
    );

    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return Scaffold(
            appBar: appBar,
            body: Container(
              child: Text("Hello!")
            )
          );
        }
      );
    
    
  }
}