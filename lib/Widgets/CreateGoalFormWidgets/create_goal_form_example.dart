import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

class CreateGoalFormExample extends StatelessWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  
  const CreateGoalFormExample({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''An example goal statment might look like: ''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            '''Read 30 minutes each day for the next three months''',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            '''or''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            '''Don't spend more than 30 every day on YouTube''',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {}, 
              child: Text("Tell Me More", style: Theme.of(context).textTheme.titleMedium),
              style: appStyle.AppThemes.largeFormButton,
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