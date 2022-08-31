import 'package:flutter/material.dart';

class AddGoalButton extends StatelessWidget {
  const AddGoalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        color: Color.fromARGB(255, 239, 239, 239),
        margin: EdgeInsets.all(20),
        child: OutlinedButton(onPressed: (){}, child: Icon(Icons.add)),
      ),
    );
  }
}

//child: OutlinedButton(onPressed: (){}, child: Icon(Icons.add)