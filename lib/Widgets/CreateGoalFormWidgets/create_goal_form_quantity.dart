import 'package:flutter/material.dart';
import 'package:micro_calendar/Widgets/back_and_next_buttons.dart';
import 'package:micro_calendar/Widgets/screen_tracker_indicators.dart';

import '../../Styles/app_themes.dart' as appStyle;

class CreateGoalFormQuantity extends StatefulWidget {
  final int totalPages;
  final int pageNumber;
  final Function nextPage;
  final Function previousPage;
  final TextEditingController quantityController;
  
  const CreateGoalFormQuantity({
    required this.totalPages, 
    required this.pageNumber, 
    required this.nextPage,
    required this.previousPage,
    required this.quantityController,
    });

  @override
  State<CreateGoalFormQuantity> createState() => _CreateGoalFormQuantityState();
}

class _CreateGoalFormQuantityState extends State<CreateGoalFormQuantity> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 20),
      child: Column(
        children: <Widget> [
          Text(
            '''Great! Now you need aquantity to make your goal truly measurable. This number is how many of the previous measurment you want to do.''',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            width: 250,
            height: 90,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Quantity", hintText: "Quantity"),
              controller: widget.quantityController,
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