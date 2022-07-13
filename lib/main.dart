import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Micro Calendar',
      theme: ThemeData(
      ),
      home: const HomePage(),
    )
  );
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () {}),
        title: const Text('Calendar Name', style: TextStyle(fontFamily: 'OpenSans')),
        centerTitle: true, 
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu), onPressed: () {},),
          IconButton(icon: Icon(Icons.arrow_right), onPressed: () {}),
        ],
      ),
    );
  }
}


