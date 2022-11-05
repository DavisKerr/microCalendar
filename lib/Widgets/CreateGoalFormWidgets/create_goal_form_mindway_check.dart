import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_footer.dart';

class CreateGoalFormMidwayCheck extends StatelessWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final TextEditingController verbController;
  final TextEditingController measurementController;
  final TextEditingController quantityController;

  const CreateGoalFormMidwayCheck({
    required this.totalPages,
    required this.pageNumber,
    required this.nextPage,
    required this.previousPage,
    required this.verbController,
    required this.measurementController,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Container(
                height: viewModel.maxHeight * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '''Here is your goal statement so far. If you don’t like how it looks, feel free to go back and change any part you like.''',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                    ),
                    Container(
                      width: viewModel.maxWidth * 0.75,
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        verbController.text + " " + quantityController.text + " " + measurementController.text + ".",
                        style: Theme.of(context).textTheme.titleMedium,
                        textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              CreateGoalFooter(
                totalPages: totalPages, 
                currentPage: pageNumber, 
                onBackClicked: previousPage, 
                onNextClicked: nextPage, 
                backText: "Back", 
                nextText: "Next"),
            ]
          )
        );
      }
    );
  }
}