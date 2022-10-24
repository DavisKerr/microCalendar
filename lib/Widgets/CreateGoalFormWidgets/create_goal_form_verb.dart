import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

class CreateGoalFormVerb extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final Function updateDontFunction;
  final bool dont;
  final TextEditingController verbController;
  
  const CreateGoalFormVerb({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    required this.dont,
    required this.updateDontFunction,
    required this.verbController,
    });

  @override
  State<CreateGoalFormVerb> createState() => _CreateGoalFormVerbState();
}

class _CreateGoalFormVerbState extends State<CreateGoalFormVerb> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''Let’s start with a goal verb. This is the “what” of your goal. You can also add a “don’t” to your verb to make it a goal to not go over. ''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.only(right: 175),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(value: widget.dont, onChanged: (value) {widget.updateDontFunction(value);}),
                Text("Dont", style: Theme.of(context).textTheme.titleMedium,)
              ],
            ),
          ),
          Container(
            width: 250,
            height: 90,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Verb", hintText: "Verb"),
              controller: widget.verbController,
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