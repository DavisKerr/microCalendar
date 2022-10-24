import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

class CreateGoalFormMeasurement extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final TextEditingController measurmentController;
  
  const CreateGoalFormMeasurement({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    required this.measurmentController,
    });

  @override
  State<CreateGoalFormMeasurement> createState() => _CreateGoalFormMeasurementState();
}

class _CreateGoalFormMeasurementState extends State<CreateGoalFormMeasurement> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''Now let’s add a goal measurement. This is whatyou will use to track your goal. This could be minutes, pounds, lessons, etc.''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            width: 250,
            height: 90,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Measurement", hintText: "Measurement"),
              controller: widget.measurmentController,
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