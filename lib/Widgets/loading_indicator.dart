import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../State/app_state.dart';
import '../View/view_model.dart';

class LoadingIndicator extends StatelessWidget {
  final String message;
  const LoadingIndicator({super.key, required this.message});

  void checkClose(bool wasLoading, bool nowLoading, BuildContext context) {
    if(wasLoading && !nowLoading) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      onDidChange: (ViewModel? oldViewModel, ViewModel newViewModel) => 
        checkClose(oldViewModel!.loading, newViewModel.loading, context) ,
      builder: (BuildContext context, ViewModel viewModel) {
        return AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 100,
              width: 50,
              child: Column(
                children: <Widget>[
                  Text(this.message),
                  SizedBox(height: 10,),
                  CircularProgressIndicator(),
                ],
              )
            ),
          ),
        );
    });
  }
}