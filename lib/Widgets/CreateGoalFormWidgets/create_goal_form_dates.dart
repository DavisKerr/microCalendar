import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';
import 'package:redux/redux.dart';

import '../../State/app_state.dart';
import '../../Styles/app_themes.dart' as appStyle;
import '../../View/view_model.dart';
import 'create_goal_footer.dart';

class CreateGoalFormDates extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final Function updateStartDate;
  final Function updateEndDate;
  final String startDate;
  final String endDate;
  //final TextEditingController contextController;
  
  const CreateGoalFormDates({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    required this.updateStartDate,
    required this.updateEndDate,
    required this.startDate,
    required this.endDate,
    });

    

  @override
  State<CreateGoalFormDates> createState() => _CreateGoalFormDatesState();
}

class _CreateGoalFormDatesState extends State<CreateGoalFormDates> {

  void _presentDatePicker(String date, Function callback) {
   showDatePicker(
    context: context,
    initialDate: DateTime.parse(date) != null ? DateTime.parse(date) : DateTime.now(), 
    firstDate: DateTime.now().subtract(Duration(days: 1460)), 
    lastDate: DateTime.now().add(Duration(days: 1460)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      else {
       callback(DateUtils.dateOnly(pickedDate));
      }
      
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Container(
          height: viewModel.maxHeight,
          width: viewModel.maxWidth,
          padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Container(
                height: viewModel.maxHeight * 0.5,
                child: Column(
                  children: <Widget>[
                    Text(
                      '''When do you want your goal to start and end?''',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start Date: ", 
                                style: Theme.of(context).textTheme.titleMedium,
                                textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                              ),
                              TextButton(onPressed: () {_presentDatePicker(widget.startDate, widget.updateStartDate);}, 
                                child: Text(
                                  widget.startDate.split(" ")[0],
                                  style: TextStyle(
                                    fontSize: 16 * (viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75), 
                                    color: Colors.deepPurple
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("End Date: ", 
                              style: Theme.of(context).textTheme.titleMedium,
                              textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                              ),
                              TextButton(onPressed: () {_presentDatePicker(widget.endDate, widget.updateEndDate);}, 
                                child: Text(
                                  widget.endDate.split(" ")[0],
                                  style: TextStyle(
                                    fontSize: 16 * (viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75), 
                                    color: Colors.deepPurple
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]
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