import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/goal.dart';
import '../Model/goal_progress.dart';
import '../Actions/goal_actions.dart';

import 'package:redux/redux.dart';

import '../View/view_model.dart';

class ConfirmationWindow extends StatefulWidget {
  final Function onConfirmAction;
  const ConfirmationWindow({required this.onConfirmAction});

  @override
  State<ConfirmationWindow> createState() => _ConfirmationWindowState();
}

class _ConfirmationWindowState extends State<ConfirmationWindow> {

  void _submitForm()
  {
    widget.onConfirmAction(context);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text("Are you sure?"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel")),
            ElevatedButton(onPressed: () {_submitForm();}, child: Text("Confirm")),
          ],
        )
      )
    );
  }
}