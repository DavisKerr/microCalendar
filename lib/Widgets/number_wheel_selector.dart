import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class NumberWheelSelector extends StatefulWidget {
  final int maxInt;
  final int minInt;
  final int initInt;
  final String title;
  const NumberWheelSelector({required this.maxInt, required this.minInt, required this.initInt, required this.title});

  @override
  State<NumberWheelSelector> createState() => _NumberWheelSelectorState();
}

class _NumberWheelSelectorState extends State<NumberWheelSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.labelSmall,),
        SizedBox(
          width: 50,
          height: 100,
          child: WheelChooser.integer(
            onValueChanged: (i) {print(i);},
            maxValue: widget.maxInt,
            minValue: widget.minInt,
            step: 1,
            unSelectTextStyle: TextStyle(fontSize: 10),
            selectTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            itemSize: 30,
            initValue: widget.initInt,
          ),
        ),
      ],
    );
  }
}