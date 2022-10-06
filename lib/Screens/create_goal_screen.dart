import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/create_goal_form_example.dart';
import 'package:micro_calendar/Widgets/create_goal_form_introduction.dart';
import 'package:micro_calendar/Widgets/create_goal_form_verb.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import '../Model/goal.dart';

class CreateGoalScreen extends StatefulWidget {

  final Store store;


  const CreateGoalScreen({required this.store});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {

  final PageController pageController = PageController();

  void _backToGoalScreen()
  {
    // TODO: Add a confirmation window here. 
    Navigator.of(context).pop();
  }

    void _previousPage()
  {
    pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _nextPage()
  {
    pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
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

    return Scaffold(
      appBar: appBar,
      body: StoreProvider(
        store: widget.store,
        child: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CreateGoalFormIntroduction(
              pageNumber: 1, 
              totalPages: 11, 
              nextPage: _nextPage,
            ),
            CreateGoalFormExample(
              totalPages: 11, 
              pageNumber: 2, 
              nextPage: _nextPage,
              previousPage: _previousPage,
            ),
            CreateGoalFormVerb(
              totalPages: 11, 
              pageNumber: 3, 
              nextPage: _nextPage, 
              previousPage: _previousPage)
          ],
        ),
      ),
    );
  }
}