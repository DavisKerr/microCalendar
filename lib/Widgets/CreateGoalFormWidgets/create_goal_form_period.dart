import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_footer.dart';

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
                      '''You can add an optional goal context further explaining your goal, like “on youtube.”''',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                    ),
                    Container(
                      child: DropdownButton<String>(
                        value: widget.chosen,
                        items: options.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,),
                          );
                        }).toList(),
                        onChanged: (value) {widget.updateChosenFunction(value);},
                        icon: const Icon(Icons.arrow_downward),
                      ),
                    ),
                  ],
                ),
              ),
              CreateGoalFooter(
                totalPages: widget.totalPages, 
                currentPage: widget.pageNumber, 
                onBackClicked: widget.previousPage, 
                onNextClicked: widget.nextPage, 
                backText: "Back", 
                nextText: "Next")
            ]
          )
        );
      }
    );
  }
}