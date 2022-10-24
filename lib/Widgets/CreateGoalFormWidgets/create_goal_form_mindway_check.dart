import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

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
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''Here is your goal statement so far. If you don’t like how it looks, feel free to go back and change any part you like.''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            width: 250,
            height: 90,
            child: Text(
              verbController.text + " " + quantityController.text + " " + measurementController.text + ".",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 50),
          BackAndNextButtons(onBackClicked: previousPage, onNextClicked: nextPage),
          ScreenTrackerIndicators(numPages: totalPages, currentPage: pageNumber),
        ]
      )
    );
  }
}