import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;
import 'create_goal_footer.dart';

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: viewModel.maxHeight * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '''An example goal statment might look like: ''',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                              textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                            ),
                            Text(
                              '''Read 30 minutes each day for the next three months''',
                              style: Theme.of(context).textTheme.displayMedium,
                              textAlign: TextAlign.center,
                              textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                            ),
                            Text(
                              '''or''',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                              textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                            ),
                            Text(
                              '''Don't spend more than 30 every day on YouTube''',
                              style: Theme.of(context).textTheme.displayMedium,
                              textAlign: TextAlign.center,
                              textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    Container(
                      width: viewModel.maxWidth * 0.75,
                      margin: EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {}, 
                        child: Text("Tell Me More", style: Theme.of(context).textTheme.titleMedium),
                        style: appStyle.AppThemes.largeFormButton,
                        ),
                    ),
                  ],
                ),
              ),
              
              CreateGoalFooter(
                totalPages: totalPages, 
                currentPage: pageNumber, 
                onBackClicked: previousPage, 
                onNextClicked: nextPage, 
                backText: "Back", 
                nextText: "Next")
            ]
          )
        );
      }
    );
  }
}