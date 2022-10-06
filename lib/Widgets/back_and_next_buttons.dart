import 'package:flutter/material.dart';

import '../Styles/app_themes.dart' as appStyle;

class BackAndNextButtons extends StatelessWidget {
  final Function onBackClicked;
  final Function onNextClicked;
  const BackAndNextButtons({required this.onBackClicked, required this.onNextClicked});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {onBackClicked();}, 
            style: appStyle.AppThemes.largeFormButton,
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_left_sharp, color: Color.fromARGB(255, 0, 0, 0)),
                Text("Back", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {onNextClicked();}, 
            style: appStyle.AppThemes.largeFormButton,
            child: Row(
              children: [
                Text("Next", style: Theme.of(context).textTheme.titleMedium),
                Icon(Icons.keyboard_arrow_right_sharp, color: Color.fromARGB(255, 0, 0, 0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}