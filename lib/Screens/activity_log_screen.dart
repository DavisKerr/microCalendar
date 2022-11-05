import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';
import 'package:micro_calendar/Widgets/ActivityLogWidgets/progress_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';
import '../View/view_model.dart';
import '../Widgets/ActivityLogWidgets/progress_list.dart';


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
      title: const Text('Activity Log', style: TextStyle(fontFamily: 'OpenSans')),
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

          AppBar appBar =_buildAppBar(viewModel, context);

          return OrientationBuilder(
          builder: (context, orientation) {
            if(
              MediaQuery.of(context).size.height - appBar.preferredSize.height != viewModel.maxHeight ||
              MediaQuery.of(context).size.width != viewModel.maxWidth
            ) {
              viewModel.setScreenDimensions(
                MediaQuery.of(context).size.height - appBar.preferredSize.height,
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).textScaleFactor
              );
            }
            
              return Scaffold(
                resizeToAvoidBottomInset : false,
                appBar: appBar,
                body: Container(
                  height: viewModel.maxHeight,
                  width: viewModel.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Progress for', 
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontSize: 24),
                              textScaleFactor: viewModel.maxHeight > 300 ? 1 : .75,
                            ),
                            Text(
                              goal.goalName, 
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontSize: 24), 
                              textScaleFactor: viewModel.maxHeight > 300 ? 1 : .75,
                            ),
                          ],
                        )
                      ),
                      
                      Container(
                        height: viewModel.maxHeight * .7,
                        width: viewModel.maxWidth,
                        child: ProgressList(goal: goal),
                      )
                    ],
                  )
                )
              );
            }
          );
        }
      );
    
    
  }
}