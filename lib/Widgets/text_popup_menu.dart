import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextPopupMenu extends StatelessWidget {
  const TextPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Menu'),
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child:  SingleChildScrollView(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {Navigator.of(context).pop();}, 
                  child: Text("Item 1"),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0), 
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
                    foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 0)),
                    minimumSize: MaterialStateProperty.all(Size(200, 50))
                  ),
                ),
              ],
            )
          )
        )
      )
    );
  }
}