import 'package:flutter/material.dart';
import 'package:micro_calendar/View/view_model.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_footer.dart';

class CreateGoalFormEnd extends StatelessWidget {
  final int totalPages;
  final int pageNumber;
  final Function previousPage;
  final Function submitGoal;
  final TextEditingController name;
  final TextEditingController verb;
  final TextEditingController measurement;
  final TextEditingController quantity;
  final String period;
  final String startDate;
  final String endDate; 

  const CreateGoalFormEnd({
    required this.totalPages,
    required this.pageNumber,
    required this.previousPage,
    required this.submitGoal,
    required this.name,
    required this.verb,
    required this.measurement,
    required this.quantity,
    required this.period,
    required this.startDate,
    required this.endDate,
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
                height: viewModel.maxHeight * 0.6,
                child: Column(
                  children: <Widget>[
                    Text(
                      '''Here is your goal statement. If you don’t like how it looks, feel free to go back and change any part you like.\n''',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                    ),
                    Text(
                      'Goal Name: ${name.text}',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                    ),
                    Container(
                      width: viewModel.maxWidth * 0.75,
                      height: viewModel.maxHeight * 0.25,
                      child: SingleChildScrollView(
                        child: Text(
                          verb.text + " " + quantity.text + 
                          " " + measurement.text + "(s) every "
                          + period + " from " + 
                          startDate.split(" ")[0] + 
                          " to " + 
                          endDate.split(" ")[0] +
                            ".",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                          textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              CreateGoalFooter(
                totalPages: totalPages, 
                currentPage: pageNumber, 
                onBackClicked: previousPage, 
                onNextClicked: submitGoal, 
                backText: "Back", 
                nextText: "Done")
            ]
          )
        );
      }
    );
  }
}