
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../State/app_state.dart';
import '../../View/view_model.dart';
import '../back_and_next_buttons.dart';
import '../screen_tracker_indicators.dart';

class CreateGoalFooter extends StatelessWidget {

  final int totalPages;
  final int currentPage;
  final Function onBackClicked;
  final Function onNextClicked;
  final String backText;
  final String nextText;

  const CreateGoalFooter({
    required this.totalPages,
    required this.currentPage,
    required this.onBackClicked,
    required this.onNextClicked,
    required this.backText,
    required this.nextText
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Container(
          width: viewModel.maxWidth,
          height: viewModel.maxHeight * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BackAndNextButtons(onBackClicked: onBackClicked, onNextClicked: onNextClicked),
              viewModel.maxWidth > 315 ?
                ScreenTrackerIndicators(
                  numPages: totalPages, 
                  currentPage: currentPage,
                  dotSize: viewModel.maxHeight > 300  ? 25 : 15,
                  )
                :
                Container(
                margin: EdgeInsets.only(top: 5),
                  child: Text(
                  '''Page ${currentPage} of ${totalPages}''',
                  textAlign: TextAlign.center,
                  textScaleFactor: .75,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}