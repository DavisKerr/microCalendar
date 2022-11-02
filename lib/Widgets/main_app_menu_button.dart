import 'package:flutter/material.dart';
import 'package:micro_calendar/SpawnPopups/spawn_popups.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/text_popup_menu.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Actions/goal_actions.dart';
import '../Model/goal.dart';
import '../State/app_state.dart';

class MainAppMenuButton extends StatelessWidget {

  MainAppMenuButton();

  _openCompletedGoalScreen(ViewModel viewModel)
  {
    viewModel.navigateToCompletedGoalScreen();
  }



  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return PopupMenuButton(
          color: Color.fromARGB(255, 255, 255, 255),
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book)
          itemBuilder: (context){
            return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Text("Completed Goals"),
                  ),

                  
              ];
          },
          onSelected:(value){
            if(value == 0){
                _openCompletedGoalScreen(viewModel);
            }
          }
        );
      }
    );
  }
}
