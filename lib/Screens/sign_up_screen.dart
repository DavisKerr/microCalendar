import 'package:flutter/material.dart';
import 'package:micro_calendar/Model/goal_progress.dart';
import 'package:micro_calendar/Widgets/ActivityLogWidgets/progress_box.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Model/goal.dart';
import '../State/app_state.dart';
import '../View/view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  AppBar _buildAppBar(ViewModel viewModel, BuildContext context) {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () => viewModel.navigateBack()),
      title: const Text('Calendar Name', style: TextStyle(fontFamily: 'OpenSans')),
      centerTitle: true, 
      actions: <Widget>[
        IconButton(icon: Icon(Icons.menu), onPressed: () {},),
      ],
    );
  }

  void _signUp(ViewModel viewModel) {
      //viewModel.signInAttempt(usernameController.text, passwordController.text);
    }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          AppBar appBar =_buildAppBar(viewModel, context);
          return OrientationBuilder(
          builder: (context, orientation) {
            if(
              MediaQuery.of(context).size.height - appBar.preferredSize.height != viewModel.maxHeight ||
              MediaQuery.of(context).size.width != viewModel.maxWidth
            ) {
              viewModel.setScreenDimensions(
                MediaQuery.of(context).size.height - appBar.preferredSize.height,
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).textScaleFactor
              );
            }
              return Scaffold(
                resizeToAvoidBottomInset : false,
                appBar: appBar,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text('Sign Up', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                        SizedBox(height: viewModel.maxHeight * 0.05),
                        TextField(
                        decoration: InputDecoration(labelText: "Username", hintText: "Username"),
                        controller: usernameController,
                        ),
                        SizedBox(height: viewModel.maxHeight * 0.05),
                        TextField(
                        decoration: InputDecoration(labelText: "Password", hintText: "Password"),
                        controller: passwordController,
                        obscureText: true,
                        ),
                        SizedBox(height: viewModel.maxHeight * 0.05),
                        TextField(
                        decoration: InputDecoration(labelText: "Confirm Password", hintText: "Confirm Password"),
                        controller: passwordController,
                        obscureText: true,
                        ),
                        SizedBox(height: viewModel.maxHeight * 0.05),
                        ElevatedButton(onPressed: () {_signUp(viewModel);}, child: Text("Sign Up")),
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }
      );
    
  }
}