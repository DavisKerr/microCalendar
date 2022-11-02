import 'package:flutter/material.dart';

class HorizontalProgressBar extends StatelessWidget {
  final double percentage;

  const HorizontalProgressBar({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) => 
      Container(
        margin: EdgeInsets.only(bottom: 3, top: 10),
        child: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: constraints.maxWidth * 0.1,
              child: FittedBox(
                child: Text('${(/*(current/total)*/ percentage * 100).toStringAsFixed(0)}%',
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 20,
              width: constraints.maxWidth * 0.8,
              child: LinearProgressIndicator(
                value: percentage//current/total,
              ),
            ),
          ],
        ),
      )
    ));
    
  }
}