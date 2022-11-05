import 'package:flutter/material.dart';

import '../Styles/app_themes.dart' as appStyle;

class BackAndNextButtons extends StatelessWidget {
  final Function onBackClicked;
  final Function onNextClicked;
  final String backText;
  final String nextText;

  const BackAndNextButtons({required this.onBackClicked, required this.onNextClicked, this.backText = "Back", 
  this.nextText = "Next"});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(backText, style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {onNextClicked();}, 
            style: appStyle.AppThemes.largeFormButton,
            child: Row(
              children: [
                Text(nextText, style: Theme.of(context).textTheme.titleMedium),
                Icon(Icons.keyboard_arrow_right_sharp, color: Color.fromARGB(255, 0, 0, 0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}