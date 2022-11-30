import 'package:flutter/material.dart';
import 'package:micro_calendar/SpawnPopups/spawn_popups.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/text_popup_menu.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Actions/goal_actions.dart';
import '../Model/goal.dart';
import '../State/app_state.dart';

class AccountMenuButton extends StatelessWidget {

  AccountMenuButton();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return PopupMenuButton(
          icon: Icon(Icons.person),
          color: Color.fromARGB(255, 255, 255, 255),
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book)
          itemBuilder: (context){
            return [
              PopupMenuItem<int>(
                enabled: false,
                  value: 100,
                  child: Text("Signed in as " + viewModel.username),
              ),
              const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Account Info"),
              ),
              const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Sync Data"),
              ),
              const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Log Out"),
              ),

                  
              ];
          },
          onSelected:(value) {
            if(value == 1) {
              viewModel.sync(viewModel.token);
            }
            else if(value == 2) {
                viewModel.logout();
            }
          }
        );
      }
    );
  }
}