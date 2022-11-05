import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

import '../../View/view_model.dart';
import '../../State/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_footer.dart';

class CreateGoalFormNotifications extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final Function updateEnableNotifications;
  final Function updateNotificationTime;
  final Function updateNotificationPeriod;
  final bool includeNotifications;
  final String notificationTime;
  final String chosenPeriod;
  final bool includePage;
  

  //final TextEditingController contextController;
  
  const CreateGoalFormNotifications({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    required this.updateEnableNotifications,
    required this.updateNotificationTime,
    required this.updateNotificationPeriod,
    required this.includeNotifications,
    required this.notificationTime,
    required this.chosenPeriod,
    this.includePage = true
    });

  @override
  State<CreateGoalFormNotifications> createState() => _CreateGoalFormNotificationsState();
}

class _CreateGoalFormNotificationsState extends State<CreateGoalFormNotifications> {


  final List<String> periodOptions = <String>['Day', 'Week',];
  final List<String> weekOptions = <String>['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];



  void _updateDay(String value)
  {
    widget.updateNotificationTime(_findLastWeekDay(DateTime.parse(widget.notificationTime), value));
  }

  String _findLastWeekDay(DateTime currentDateTime, String dayOfWeek) {
    while(DateFormat('EEEE').format(currentDateTime) != dayOfWeek) {
      currentDateTime = currentDateTime.subtract(Duration(hours:24));
    }
    return currentDateTime.toString();
  }

  void _presentTimePicker(String dateTime) {
    showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(DateTime.parse(dateTime))
    ).then( (pickedTime) {
      if (pickedTime == null) {
        return;
      }
      else {
        setState(() {
          DateTime currentDate = DateTime.parse(dateTime);
            widget.updateNotificationTime(
              DateTime(
                currentDate.year, 
                currentDate.month, 
                currentDate.day, 
                pickedTime.hour, 
                pickedTime.minute
              ).toString()
            );

        });
      }
    });
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
                child: Column(
                  children: <Widget>[
                    Container(
                      height: viewModel.maxHeight * 0.3,
                      child: Column(
                        children: <Widget>[
                          Text(
                            '''Notification settings''',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                            textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(value: widget.includeNotifications, onChanged: (value) {widget.updateEnableNotifications(value);}),
                              Text(
                                "Enable Notifications", 
                                style: Theme.of(context).textTheme.titleMedium,
                                textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,)
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Container(
                      height: viewModel.maxHeight * 0.35,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[       
                          widget.includeNotifications ? 
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Notify me every ", 
                                        style: Theme.of(context).textTheme.titleMedium,
                                        textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                                      ),
                                      DropdownButton<String>(
                                        value: widget.chosenPeriod,
                                        items: periodOptions.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {widget.updateNotificationPeriod(value);},
                                        icon: const Icon(Icons.arrow_downward),
                                      ),
                                    ],
                                  ),
                                  widget.chosenPeriod == "Week" ? 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "On", 
                                        style: Theme.of(context).textTheme.titleMedium,
                                        textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                                      ),
                                      SizedBox(width: 5),
                                      DropdownButton<String>(
                                        value: DateFormat('EEEE').format(DateTime.parse(widget.notificationTime)),
                                        items: weekOptions.map<DropdownMenuItem<String>>((String day) {
                                          return DropdownMenuItem<String>(
                                            value: day,
                                            child: Text(
                                              day,
                                              textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {_updateDay(value!);},
                                        icon: const Icon(Icons.arrow_downward),
                                      ),
                                    ],
                                  )
                                  : 
                                  SizedBox(),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "At", 
                                        style: Theme.of(context).textTheme.titleMedium,
                                        textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                                      ),
                                      TextButton(onPressed: () {
                                        _presentTimePicker(widget.notificationTime,);
                                      }, 
                                        child: Text(
                                        DateFormat("h:mma").format(DateTime.parse(widget.notificationTime)),
                                          style: TextStyle(fontSize: 23, color: Colors.deepPurple, fontFamily: 'OpenSans', fontWeight: FontWeight.w400,),
                                          textScaleFactor: viewModel.maxWidth > 400 && viewModel.maxHeight > 400 ? 1 : .75,
                                        ),
                                      ),
                                    ],
                                  )
                                ]
                              ),
                            )
                            : 
                            SizedBox(),
                          ],
                        ),
                      ),
                    )
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