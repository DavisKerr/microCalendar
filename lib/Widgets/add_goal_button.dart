import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class AddGoalButton extends StatelessWidget {
  final Function changeToGoalScreen;
  final Store store;
  const AddGoalButton({required this.changeToGoalScreen, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        color: Color.fromARGB(255, 239, 239, 239),
        margin: EdgeInsets.all(20),
        child: OutlinedButton(onPressed: (){changeToGoalScreen(context, store);}, child: Icon(Icons.add)),
      ),
    );
  }
}

//child: OutlinedButton(onPressed: (){}, child: Icon(Icons.add)