import 'package:flutter/material.dart';

class ScreenTrackerIndicators extends StatelessWidget {
  final int numPages;
  final int currentPage;
  final double dotSize;
  
  const ScreenTrackerIndicators({required this.numPages, required this.currentPage, required this.dotSize});

  List<Widget> _createDots()
  {
    List<Widget> dots = [];
    for(int i = 0; i < numPages; i++)
    {
      if(i == (currentPage - 1))
      {
        dots.add(Icon(Icons.brightness_1, size: dotSize,));
      }
      else
      {
        dots.add(Icon(Icons.brightness_1_outlined, size: dotSize,));
      }
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _createDots(),
      ),
    );
  }
}