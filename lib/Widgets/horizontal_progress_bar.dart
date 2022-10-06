import 'package:flutter/material.dart';

class HorizontalProgressBar extends StatelessWidget {
  final double total;
  final double? current;

  const HorizontalProgressBar({required this.total, required this.current});

  double getPercentage()
  {
    if(current == null)
    {
      return 0;
    }
    else
    {
      return current! / total;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) => 
      Container(
        margin: EdgeInsets.only(bottom: 25, top: 10),
        child: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: constraints.maxWidth * 0.1,
              child: FittedBox(
                child: Text('${(getPercentage() * 100).toString()}%',)
                ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 20,
              width: constraints.maxWidth * 0.8,
              child: LinearProgressIndicator(
                value: getPercentage(),
              ),
            ),
          ],
        ),
      )
    ));
    
  }
}