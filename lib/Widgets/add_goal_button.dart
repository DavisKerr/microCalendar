import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../State/app_state.dart';
import '../View/view_model.dart';

class AddGoalButton extends StatelessWidget {
  
  const AddGoalButton();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Container(
          height: 150,
          child: Card(
            color: Color.fromARGB(255, 239, 239, 239),
            margin: EdgeInsets.all(20),
            child: OutlinedButton(onPressed: (){viewModel.navigateToGoalCreationScreen();}, child: Icon(Icons.add)),
          ),
        );
      }
    );
  }
}

//child: OutlinedButton(onPressed: (){}, child: Icon(Icons.add)