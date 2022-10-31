import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';
import 'package:micro_calendar/Widgets/progress_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';
import '../View/view_model.dart';


class ActivityLogScreen extends StatelessWidget {
  final Goal goal;

  const ActivityLogScreen({required this.goal});

  void _backToGoalScreen(BuildContext context)
  {
    // TODO: Add a confirmation window here. 
    Navigator.of(context).pop();
  }

  AppBar _buildAppBar(ViewModel viewModel, BuildContext context) {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () => viewModel.navigateBack()),
      title: const Text('Calendar Name', style: TextStyle(fontFamily: 'OpenSans')),
      centerTitle: true, 
      actions: <Widget>[
        IconButton(icon: Icon(Icons.menu), onPressed: () {},),
        viewModel.signedIn ? 
        IconButton(icon: Icon(Icons.person), onPressed: () {}) :
        TextButton(
          child: Text("Sign In", ), 
          onPressed: () {viewModel.navigateToLoginScreen();}, 
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return Scaffold(
            appBar: _buildAppBar(viewModel, context),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text('Progress for', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                  Text(goal.goalName, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                  Container(
                    height: 500,
                    width: 300,
                    child: StoreConnector<AppState, ViewModel>(
                      converter: (Store<AppState> store) => ViewModel.create(store),
                      builder: (BuildContext context, ViewModel viewModel) {
                        Iterable<GoalProgress> items = viewModel.goalList.where((i) => i.goalId == goal.goalId).first.goalProgress;
                        return Container (
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items.elementAt(index);
                              return ProgressBox(progress: item, units: goal.goalUnits, goal: goal, viewModel: viewModel,);
                            },
                          ),
                        );
                      }
                    )
                  )
                ],
              )
            )
          );
        }
      );
    
    
  }
}