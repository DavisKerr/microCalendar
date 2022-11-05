import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_footer.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';



import '../../Styles/app_themes.dart' as appStyle;

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Container(
          height: viewModel.maxHeight * 0.5,
          width: viewModel.maxWidth,
          padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Container(
                height: viewModel.maxHeight * 0.5,
                width: viewModel.maxWidth,
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
                      width: viewModel.maxWidth * 0.75,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Context", hintText: "Context", floatingLabelBehavior: FloatingLabelBehavior.never,),
                        controller: widget.contextController,
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