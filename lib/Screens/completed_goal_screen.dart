import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_calendar/Model/goal_progress.dart';
import 'package:micro_calendar/Widgets/ActivityLogWidgets/progress_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';
import '../Utils/date_formatter.dart';
import '../View/view_model.dart';
import '../Widgets/horizontal_progress_bar.dart';
import '../Widgets/large_completed_goal_menu_button.dart';


class CompletedGoalScreen extends StatelessWidget {

  const CompletedGoalScreen();


  AppBar _buildAppBar(ViewModel viewModel, BuildContext context) {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () => viewModel.navigateBack()),
      title: const Text('Completed Goals', style: TextStyle(fontFamily: 'OpenSans')),
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
          AppBar appBar = _buildAppBar(viewModel, context);
          Iterable<Goal> completeGoals = viewModel.goalList.where((goal) => goal.complete);
          return OrientationBuilder(
            builder: (context, orientation) {
             if(
              MediaQuery.of(context).size.height - appBar.preferredSize.height != viewModel.maxHeight ||
              MediaQuery.of(context).size.width != viewModel.maxWidth
            ) {
              viewModel.setScreenDimensions(
                MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top,
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).textScaleFactor
              );
            }
              return Scaffold(
                appBar: appBar,
                body: Container(
                  height: viewModel.maxHeight,
                  width: viewModel.maxWidth,
                  child: ListView.builder(
                    itemCount: completeGoals.length,
                    itemBuilder: (context, index) {
                      final item = completeGoals.elementAt(index);
                      return Container(
                        width: viewModel.maxWidth * .75,
                        height: 150,
                        child: Card(
                          margin: EdgeInsets.only(left: 20, bottom:20, top:20, right: 20),
                          color: Theme.of(context).cardColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 150,
                                width: viewModel.maxWidth * 0.65,
                                child: GestureDetector(
                                  onTap: () {},
                                  onLongPress: () {},
                                  child: Card(
                                    elevation: 0,
                                    margin: EdgeInsets.all(0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          item.goalName,
                                          style: Theme.of(context).textTheme.titleMedium
                                        ),
                                        Text("Ended ${DateFormatter.formatter.format(DateTime.parse(item.goalEndDate))}"),
                                        HorizontalProgressBar(
                                          percentage: item.progressPercentage, 
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: LargeCompletedGoalMenuButton(
                                  goal: item,
                                )
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              );
            }
          );
        }
      );
    
    
  }
}