import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:micro_calendar/Actions/goal_actions.dart';
import 'package:micro_calendar/Model/goal_notification.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_context.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_dates.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_end.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_introduction.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_example.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_measurement.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_mindway_check.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_name.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_notifications.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_period.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_quantity.dart';
import 'package:micro_calendar/Widgets/CreateGoalFormWidgets/create_goal_form_verb.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';
import '../View/view_model.dart';

class CreateGoalScreen extends StatefulWidget {


  const CreateGoalScreen();

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {

  final PageController pageController = PageController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController verbController = TextEditingController();
  final TextEditingController measurementController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController contextController = TextEditingController();

  String period = "Day";
  String startDate = "00/00/00";
  String endDate = "00/00/00";
  ViewModel? viewModel = null;

  bool enableNotifications = false;
  String notificationTime = "";
  int notificationPeriod = 0;

  bool nameError = false;
  bool verbError = false; 
  bool measurementError = false;
  bool quantityError = false;
  bool contextError = false;
  
  /*
  * Error Handling functions
  */
  bool _checkNameError() {
    String name = nameController.text;
    final pattern = RegExp(r'^[a-zA-Z0-9 ]+$');
    if(pattern.hasMatch(name) && name.length < 30) {
      setState(() {
        nameError = false;
      });
    }
    else {
      setState(() {
        nameError = true;
      });
    }
    return nameError;
  }

  bool _checkVerbError() {
    String verb = verbController.text;
    final pattern = RegExp(r'^[a-zA-Z0-9 ]+$');
    if(pattern.hasMatch(verb) && verb.length < 20) {
      setState(() {
        verbError = false;
      });
    }
    else {
      setState(() {
        verbError = true;
      });
    }
    return verbError;
  }

  bool _checkMeasurementError() {
    String measurement = measurementController.text;
    final pattern = RegExp(r'^[a-zA-Z0-9 ]+$');
    if(pattern.hasMatch(measurement) && measurement.length < 20) {
      setState(() {
        measurementError = false;
      });
    }
    else {
      setState(() {
        measurementError = true;
      });
    }
    return measurementError;
  }

  bool _checkQuantityError() {
    String quantity = quantityController.text;
    final pattern = RegExp(r'^[0-9]+$');
    if(pattern.hasMatch(quantity) && quantity.length < 20) {
      setState(() {
        quantityError = false;
      });
    }
    else {
      setState(() {
        quantityError = true;
      });
    }
    return quantityError;
  }

  bool _checkContextError() {
    String context = contextController.text;
    final pattern = RegExp(r'^[a-zA-Z0-9 ]*$');
    if(pattern.hasMatch(context) && context.length < 50) {
      setState(() {
        contextError = false;
      });
    }
    else {
      setState(() {
        contextError = true;
      });
    }
    return contextError;
  }

  void _updateStartDate(DateTime date)
  {
    setState(() {
      startDate = '$date';
    });
  }

  void _updateEndDate(DateTime date)
  {
    setState(() {
      endDate = '$date';
    });
  }

  void _updatePeriodState(String value)
  {
    setState(() {
      period = value;
    });
  }

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


  void _previousPage()
  {
    pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _nextPage()
  {
    pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _submitGoal()
  {
    print("Submitting...");
    Goal newGoal = Goal(
      goalName: nameController.text,
      goalVerb: verbController.text,
      goalQuantity: double.parse(quantityController.text),
      goalUnits: measurementController.text,
      goalContext: contextController.text,
      goalPeriod: period == "Day" ? PeriodUnit.day : period == "Week" ? PeriodUnit.week : PeriodUnit.month,
      goalStartDate: startDate,
      goalEndDate: endDate,
      goalId: -1,
      progressPercentage: 0.0,
    );

    GoalNotification newNotification = GoalNotification(notificationId: -1, goalName: newGoal.goalName, goalId: -1, timeAndDay: notificationTime, period: notificationPeriod);

    if(this.viewModel != null)
    {
      if(enableNotifications) {
        this.viewModel!.createGoalWithNotifications(newGoal, newNotification);
      }
      else {
        this.viewModel!.createGoal(newGoal);
      }
    }
    
    
    viewModel!.navigateBack();
  }

  AppBar _buildAppBar(ViewModel viewModel, BuildContext context) {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () => viewModel.navigateBack()),
      title: const Text('Calendar Name', style: TextStyle(fontFamily: 'OpenSans')),
      centerTitle: true, 
      actions: <Widget>[
        IconButton(icon: Icon(Icons.menu), onPressed: () {},),
        viewModel.signedIn ? 
        IconButton(icon: Icon(Icons.person), onPressed: () {}) :
        TextButton(
          child: Text("Sign In", ), 
          onPressed: () {viewModel.navigateToLoginScreen();}, 
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    startDate = startDate != '00/00/00' ? startDate : '${DateUtils.dateOnly(DateTime.now())}';
    endDate = endDate != '00/00/00' ? endDate : '${DateUtils.dateOnly(DateTime.now().add(Duration(days: 90)))}';
    notificationTime = notificationTime == "" ?  DateTime.now().toString() : notificationTime;

    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {

        this.viewModel = viewModel;
        AppBar appBar =_buildAppBar(viewModel, context);

          return OrientationBuilder(
          builder: (context, orientation) {
           if(
              MediaQuery.of(context).size.height - appBar.preferredSize.height != viewModel.maxHeight ||
              MediaQuery.of(context).size.width != viewModel.maxWidth
            ) {
              viewModel.setScreenDimensions(
                MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top,
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).textScaleFactor
              );
            }
            return Scaffold(
              resizeToAvoidBottomInset : false,
              appBar: appBar,
              body: Container(
                width: viewModel.maxWidth,
                height: viewModel.maxHeight,
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    CreateGoalFormIntroduction(
                      pageNumber: 1, 
                      totalPages: 12, 
                      nextPage: _nextPage,
                    ),
                    CreateGoalFormExample(
                      totalPages: 12, 
                      pageNumber: 2, 
                      nextPage: _nextPage,
                      previousPage: _previousPage,
                    ),
                    CreateGoalFormName(
                      totalPages: 12, 
                      pageNumber: 3, 
                      nextPage: _nextPage, 
                      previousPage: _previousPage, 
                      nameController: nameController,
                      nameError: nameError,
                      checkNameError: _checkNameError,
                    ),
                    CreateGoalFormVerb(
                      totalPages: 12, 
                      pageNumber: 4, 
                      nextPage: _nextPage, 
                      previousPage: _previousPage,
                      verbController: verbController,
                      verbError: verbError,
                      checkVerbError: _checkVerbError,
                    ),
                    CreateGoalFormMeasurement(
                      totalPages: 12, 
                      pageNumber: 5,
                      nextPage: _nextPage, 
                      previousPage: _previousPage, 
                      measurmentController: measurementController,
                      measurementError: measurementError,
                      checkMeasurementError: _checkMeasurementError,
                    ),
                    CreateGoalFormQuantity(
                      totalPages: 12, 
                      pageNumber: 6, 
                      nextPage: _nextPage, 
                      previousPage: _previousPage, 
                      quantityController: quantityController,
                      quantityError: quantityError,
                      checkQuantityError: _checkQuantityError,
                    ),
                    CreateGoalFormMidwayCheck(
                      totalPages: 12, 
                      pageNumber: 7, 
                      nextPage: _nextPage, 
                      previousPage: _previousPage, 
                      verbController: verbController, 
                      measurementController: measurementController, 
                      quantityController: quantityController),
                    CreateGoalFormPeriod(
                      totalPages: 12, 
                      pageNumber: 8, 
                      nextPage: _nextPage, 
                      updateChosenFunction: _updatePeriodState, 
                      previousPage: _previousPage, 
                      chosen: period,
                    ),
                    CreateGoalFormContext(
                      totalPages: 12, 
                      pageNumber: 9, 
                      nextPage: _nextPage, 
                      previousPage: _previousPage, 
                      contextController: contextController,
                      contextError: contextError,
                      checkContextError: _checkContextError,
                    ),
                    CreateGoalFormDates(
                      totalPages: 12, 
                      pageNumber: 10, 
                      nextPage: _nextPage, 
                      previousPage: _previousPage, 
                      updateStartDate: _updateStartDate, 
                      updateEndDate: _updateEndDate, 
                      startDate: startDate,
                      endDate: endDate,
                    ),
                    CreateGoalFormNotifications(
                      totalPages: 12, 
                      pageNumber: 11, 
                      nextPage: _nextPage, 
                      previousPage: _previousPage,
                      updateEnableNotifications: _updateEnableNotificationsState,
                      updateNotificationTime: _updateNotificationTimeState,
                      updateNotificationPeriod: _updateNotificationPeriodState,
                      includeNotifications: enableNotifications,
                      notificationTime: notificationTime,
                      chosenPeriod: notificationPeriod == 0 ? "Day" : "Week",
                    ),
                    CreateGoalFormEnd(
                      totalPages: 12, 
                      pageNumber: 12, 
                      previousPage: _previousPage, 
                      submitGoal: _submitGoal, 
                      name: nameController,
                      verb: verbController, 
                      measurement: measurementController, 
                      quantity: quantityController, 
                      period: period, 
                      startDate: startDate, 
                      endDate: endDate,
                    ),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}