import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_footer.dart';

class CreateGoalFormMeasurement extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final TextEditingController measurmentController;
  final bool measurementError;
  final Function checkMeasurementError;
  
  const CreateGoalFormMeasurement({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    required this.measurmentController,
    required this.measurementError,
    required this.checkMeasurementError,
    });

  @override
  State<CreateGoalFormMeasurement> createState() => _CreateGoalFormMeasurementState();
}

class _CreateGoalFormMeasurementState extends State<CreateGoalFormMeasurement> {

  void _onNextClicked() {
    if(!widget.checkMeasurementError())
    {
      widget.nextPage();
    }
  }

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '''Now let’s add a goal measurement. This is whatyou will use to track your goal. This could be minutes, pounds, lessons, etc.''',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                    ),
                    widget.measurementError ? 
                      Text(
                          '''Goal measurements must have only letters and numbers and be less than 30 characters!''',
                          style: appStyle.AppThemes.errorText,
                          textAlign: TextAlign.center,
                          textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                      )
                    : 
                    SizedBox(height: 14),
                    Container(
                      width: viewModel.maxWidth * 0.75,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Measurement", hintText: "Measurement", floatingLabelBehavior: FloatingLabelBehavior.never,),
                        controller: widget.measurmentController,
                        style: TextStyle(fontSize: 24 * (viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75)),
                      ),
                    ),
                  ],
                ),
              ),
              CreateGoalFooter(
                totalPages: widget.totalPages, 
                currentPage: widget.pageNumber, 
                onBackClicked: widget.previousPage, 
                onNextClicked: _onNextClicked, 
                backText: "Back", 
                nextText: "Next"),
            ]
          )
        );
      }
    );
  }
}