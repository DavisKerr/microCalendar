import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:micro_calendar/Actions/goal_actions.dart';
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

  bool dont = false;
  String period = "Day";
  String startDate = "00/00/00";
  String endDate = "00/00/00";
  ViewModel? viewModel = null;

  void _backToGoalScreen()
  {
    // TODO: Add a confirmation window here. 
    Navigator.of(context).pop();
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

  void _updateDontState(bool value)
  {
    setState(() {
      dont = value;
    });
  }

  void _updatePeriodState(String value)
  {
    setState(() {
      period = value;
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
    if(this.viewModel != null)
    {
      this.viewModel!.createGoal(newGoal);
    }
    
    
    _backToGoalScreen();
  }

  @override
  Widget build(BuildContext context) {

    AppBar appBar = AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: _backToGoalScreen),
      title: const Text('Calendar Name', style: TextStyle(fontFamily: 'OpenSans')),
      centerTitle: true, 
      actions: <Widget>[
        IconButton(icon: Icon(Icons.menu), onPressed: () {},),
        IconButton(icon: Icon(Icons.arrow_right), onPressed: () {}),
      ],
    );

    startDate = startDate != '00/00/00' ? startDate : '${DateUtils.dateOnly(DateTime.now())}';
    endDate = endDate != '00/00/00' ? endDate : '${DateUtils.dateOnly(DateTime.now().add(Duration(days: 90)))}';

    return Scaffold(
      appBar: appBar,
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          this.viewModel = viewModel;
          return PageView(
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
                nameController: nameController
              ),
              CreateGoalFormVerb(
                totalPages: 12, 
                pageNumber: 4, 
                nextPage: _nextPage, 
                previousPage: _previousPage,
                dont: dont,
                updateDontFunction: _updateDontState,
                verbController: verbController,
              ),
              CreateGoalFormMeasurement(
                totalPages: 12, 
                pageNumber: 5,
                nextPage: _nextPage, 
                previousPage: _previousPage, 
                measurmentController: measurementController
              ),
              CreateGoalFormQuantity(
                totalPages: 12, 
                pageNumber: 6, 
                nextPage: _nextPage, 
                previousPage: _previousPage, 
                quantityController: quantityController),
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
                contextController: contextController),
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
                dont: dont, 
                startDate: startDate, 
                endDate: endDate,
              ),
            ],
          );
        }
      )
    );
  }
}