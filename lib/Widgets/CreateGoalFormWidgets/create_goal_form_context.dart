import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

class CreateGoalFormContext extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final TextEditingController contextController;
  
  const CreateGoalFormContext({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    required this.contextController,
    });

  @override
  State<CreateGoalFormContext> createState() => _CreateGoalFormContextState();
}

class _CreateGoalFormContextState extends State<CreateGoalFormContext> {

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
            width: 250,
            height: 90,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Context", hintText: "Context"),
              controller: widget.contextController,
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