import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CreateGoalFormIntroduction extends StatelessWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  //final PageController pageController;
  
  const CreateGoalFormIntroduction({required this.totalPages, required this.pageNumber, required this.nextPage});

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
                  children: <Widget>[
                    Text(
                      '''Ready to start creating your goal with a powerful goal statement?''',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: viewModel.maxWidth * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {nextPage();}, 
                        child: Text("Let's Go!", style: Theme.of(context).textTheme.titleMedium),
                        style: appStyle.AppThemes.largeFormButton,
                        ),
                    ),
                  ],
                ),
              ),
              viewModel.maxWidth > 315 ?
                ScreenTrackerIndicators(
                  numPages: totalPages, 
                  currentPage: pageNumber,
                  dotSize: viewModel.maxHeight > 300 ? 25 : 15,
                )
                :
                Container(
                margin: EdgeInsets.only(top: 5),
                  child: Text(
                  '''Page ${pageNumber} of ${totalPages}''',
                  textAlign: TextAlign.center,
                  textScaleFactor: .75,
                ),
              ),
            ]
          )
        );
      }
    );
  }
}