import 'package:flutter/material.dart';

class ScreenTrackerIndicators extends StatelessWidget {
  final int numPages;
  final int currentPage;
  const ScreenTrackerIndicators({required this.numPages, required this.currentPage});

  List<Widget> _createDots()
  {
    List<Widget> dots = [];
    for(int i = 0; i < numPages; i++)
    {
      if(i == (currentPage - 1))
      {
        dots.add(Icon(Icons.brightness_1));
      }
      else
      {
        dots.add(Icon(Icons.brightness_1_outlined));
      }
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _createDots(),
      ),
    );
  }
}