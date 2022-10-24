import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

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
  final bool dont;
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
    required this.dont,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''Here is your goal statement. If you don’t like how it looks, feel free to go back and change any part you like.\n''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            'Goal Name: ${name.text}',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            width: 250,
            height: 300,
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
              ),
            ),
          ),
          SizedBox(height: 50),
          BackAndNextButtons(onBackClicked: previousPage, onNextClicked: submitGoal, nextText: "Done",),
          ScreenTrackerIndicators(numPages: totalPages, currentPage: pageNumber, ),
        ]
      )
    );
  }
}