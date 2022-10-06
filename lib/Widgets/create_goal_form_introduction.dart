import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../Styles/app_themes.dart' as appStyle;

class CreateGoalFormIntroduction extends StatelessWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  //final PageController pageController;
  
  const CreateGoalFormIntroduction({required this.totalPages, required this.pageNumber, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''Ready to start creating your goal with a powerful goal statement?''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            width: 250,
            height: 100,
            child: ElevatedButton(
              onPressed: () {nextPage();}, 
              child: Text("Let's Go!", style: Theme.of(context).textTheme.titleMedium),
              style: appStyle.AppThemes.largeFormButton,
              ),
          ),
          ScreenTrackerIndicators(numPages: totalPages, currentPage: pageNumber),
        ]
      )
    );
  }
}