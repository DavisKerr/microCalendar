import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:micro_calendar/Actions/db_actions.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_notifications.dart';
import 'package:micro_calendar/Widgets/confirmation_window.dart';


import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/goal_actions.dart';
import '../State/app_state.dart';
import '../View/view_model.dart';
import '../Widgets/number_wheel_selector.dart';

import 'package:redux/redux.dart';

class EditGoalNotificationPopup extends StatefulWidget {
  final Goal goal;
  final ViewModel viewModel;

  const EditGoalNotificationPopup({required this.goal, required this.viewModel});

  @override
  State<EditGoalNotificationPopup> createState() => _EditGoalNotificationPopupState();
}

class _EditGoalNotificationPopupState extends State<EditGoalNotificationPopup> {


  bool enableNotifications = true;
  String notificationTime = "";
  int notificationPeriod = -1;

  void _updateEnableNotificationsState(bool value)
  {
    setState(() {
      enableNotifications = value;
    });
  }

  void _updateNotificationTimeState(String value)
  {
    setState(() {
      notificationTime = value;
    });
  }

  void _updateNotificationPeriodState(String value)
  {
    setState(() {
      notificationPeriod = value == "Day" ? 0 : 1;
    });
  }

  void _submitForm(ViewModel viewModel) {
    print("Running like expected");
    GoalNotification updated = GoalNotification(
      notificationId: viewModel.notification.notificationId,
      goalName: viewModel.notification.goalName, 
      timeAndDay: notificationTime, 
      goalId: viewModel.notification.goalId, 
      period: notificationPeriod);
    viewModel.updateGoalNotification(updated);
    
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      onInit: (store) => {store.dispatch(LoadGoalNotificationAttemptAction(widget.goal.goalId))},
      builder: (BuildContext context, ViewModel viewModel) {

        if(viewModel.notification.goalId == -1) {
          return AlertDialog(
            scrollable: true,
            title: Text('Edit ${widget.goal.goalName} Notifications'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        else {
          
          notificationTime = notificationTime == "" ? viewModel.notification.timeAndDay : notificationTime;
          notificationPeriod = notificationPeriod == -1 ? viewModel.notification.period : notificationPeriod;
          return AlertDialog(
            scrollable: true,
            title: Text('Edit ${widget.goal.goalName} Notifications'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 400,
                    child: CreateGoalFormNotifications(
                      totalPages: 0, 
                      pageNumber: 0, 
                      nextPage: () {}, 
                      previousPage: () {}, 
                      updateEnableNotifications: _updateEnableNotificationsState, 
                      updateNotificationTime: _updateNotificationTimeState, 
                      updateNotificationPeriod: _updateNotificationPeriodState, 
                      includeNotifications: enableNotifications, 
                      notificationTime: notificationTime, 
                      chosenPeriod: notificationPeriod == 0 ? "Day" : "Week",
                      includePage: false)
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel")),
                    ElevatedButton(onPressed: () {_submitForm(viewModel); Navigator.of(context).pop();}, child: Text("Confirm")),
                  ],
                ),
                ],
              ),
            ),
          );

        }
      });
    
    
    
    // Container(
    //   padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
    //   child: Column(
    //     children: <Widget> [
    //       Text(
    //         '''Notification settings''',
    //         style: Theme.of(context).textTheme.titleMedium,
    //         textAlign: TextAlign.center,
    //       ),
    //       SizedBox(height: 50),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Checkbox(value: widget.includeNotifications, onChanged: (value) {widget.updateEnableNotifications(value);}),
    //           Text("Enable Notifications", style: Theme.of(context).textTheme.titleMedium,)
    //         ],
    //       ),
                    
    //       widget.includeNotifications ? 
    //         Container(
    //           child: Column(
    //             children: <Widget>[
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text("Notify me every ", style: Theme.of(context).textTheme.titleMedium,),
    //                   DropdownButton<String>(
    //                     value: widget.chosenPeriod,
    //                     items: periodOptions.map<DropdownMenuItem<String>>((String value) {
    //                       return DropdownMenuItem<String>(
    //                         value: value,
    //                         child: Text(value),
    //                       );
    //                     }).toList(),
    //                     onChanged: (value) {widget.updateNotificationPeriod(value);},
    //                     icon: const Icon(Icons.arrow_downward),
    //                   ),
    //                 ],
    //               ),

    //               widget.chosenPeriod == "Week" ? 
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Text("On", style: Theme.of(context).textTheme.titleMedium,),
    //                   SizedBox(width: 5),
    //                   DropdownButton<String>(
    //                     value: DateFormat('EEEE').format(DateTime.parse(widget.notificationTime)),
    //                     items: weekOptions.map<DropdownMenuItem<String>>((String day) {
    //                       return DropdownMenuItem<String>(
    //                         value: day,
    //                         child: Text(day),
    //                       );
    //                     }).toList(),
    //                     onChanged: (value) {_updateDay(value!);},
    //                     icon: const Icon(Icons.arrow_downward),
    //                   ),
    //                 ],
    //               )
    //               : 
    //               SizedBox(),

    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Text("At", style: Theme.of(context).textTheme.titleMedium,),
    //                   TextButton(onPressed: () {
    //                     _presentTimePicker(widget.notificationTime,);
    //                   }, 
    //                     child: Text(
    //                      DateFormat("h:mma").format(DateTime.parse(widget.notificationTime)),
    //                       style: TextStyle(fontSize: 23, color: Colors.deepPurple, fontFamily: 'OpenSans', fontWeight: FontWeight.w400,),
    //                     ),
    //                   ),
    //                 ],
    //               )
    //             ]
    //           ),
    //         )
    //         : 
    //         SizedBox(),
    //     ]
    //   )
    // );
  }
}