import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

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
            child: Column(children: [
                Row(
                  children: [
                    Text("Start Date: ", style: Theme.of(context).textTheme.titleMedium,),
                    TextButton(onPressed: () {_presentDatePicker(widget.startDate, widget.updateStartDate);}, 
                      child: Text(
                        widget.startDate.split(" ")[0],
                        style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("End Date: ", style: Theme.of(context).textTheme.titleMedium,),
                    TextButton(onPressed: () {_presentDatePicker(widget.endDate, widget.updateEndDate);}, 
                      child: Text(
                        widget.endDate.split(" ")[0],
                        style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                      ),
                    ),
                  ],
                )
              ],
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