import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

class CreateGoalFormPeriod extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final Function updateChosenFunction;
  final String chosen;
  //final TextEditingController contextController;
  
  const CreateGoalFormPeriod({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.updateChosenFunction,
    required this.previousPage,
    required this.chosen,
    });

  @override
  State<CreateGoalFormPeriod> createState() => _CreateGoalFormPeriodState();
}

class _CreateGoalFormPeriodState extends State<CreateGoalFormPeriod> {
  final List<String> options = <String>['Day', 'Week', 'Month',];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''You can add an optional goal context further explaining your goal, like “on youtube.”''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            child: DropdownButton<String>(
              value: widget.chosen,
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {widget.updateChosenFunction(value);},
              icon: const Icon(Icons.arrow_downward),
            ),
          ),
          SizedBox(height: 50),
          BackAndNextButtons(onBackClicked: widget.previousPage, onNextClicked: widget.nextPage),
          ScreenTrackerIndicators(numPages: widget.totalPages, currentPage: widget.pageNumber),
        ]
      )
    );
  }
}