import 'package:flutter/material.dart';
import 'package:micro_calendar/Actions/db_actions.dart';
import 'package:micro_calendar/Middleware/screen_navigation_middleware.dart';
import 'package:micro_calendar/Screens/activity_log_screen.dart';
import 'package:micro_calendar/Screens/create_goal_screen.dart';
import 'package:micro_calendar/Utils/navigator_key.dart';
import 'package:micro_calendar/Widgets/main_app_menu_button.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'Middleware/account_middleware.dart';
import 'Middleware/db_middleware.dart';
import 'Middleware/notification_middleware.dart';
import 'Model/goal.dart';

import 'Screens/splash_screen.dart';
import 'Utils/notification_service.dart';
import 'View/view_model.dart';
import 'Widgets/goal_screen.dart';
import 'Reducers/Reducer.dart';
import 'State/app_state.dart';
import 'Styles/app_themes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _launching = true;
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store =
        Store<AppState>(
          appStateReducer, 
          initialState: AppState.empty(),
          middleware: [accountMiddleware, navigationMiddleware, dbMiddleware, notificationMiddleware],
        );
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: AppThemes.defaultTheme,
        home: StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel viewModel) {
            if(_launching)
            {
              viewModel.loadData();
              _launching = false;
            }
            return viewModel.initLoading ? SplashScreen() : HomePage();
          }
        )
      )
    );
  }
}



class HomePage extends StatelessWidget {
  const HomePage({super.key});


  void _changeToGoalCreateScreen(BuildContext ctx)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return CreateGoalScreen();
    }));
  }

  void _changeToGoalActivityLogScreen(BuildContext ctx, Goal goal)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ActivityLogScreen(goal: goal);
    }));
  }

  AppBar _buildAppBar(ViewModel viewModel, BuildContext context)
  {
    return AppBar(
      title: const Text('Goals', style: TextStyle(fontFamily: 'OpenSans')),
      centerTitle: true, 
      actions: <Widget>[
        MainAppMenuButton(),
        viewModel.signedIn ? 
        IconButton(icon: Icon(Icons.person), onPressed: () {}) :
        TextButton(
          child: Text("Sign In", ), 
          onPressed: () {viewModel.navigateToLoginScreen();}, 
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        AppBar appBar = _buildAppBar(viewModel, context);
        return Scaffold(
          appBar: appBar,
          body: GoalScreen(
            maxHeight: MediaQuery.of(context).size.height - appBar.preferredSize.height,
            maxWidth: MediaQuery.of(context).size.width,
            changeToCreateGoalScreen: _changeToGoalCreateScreen,
            changeToActivityLogScreen: _changeToGoalActivityLogScreen,
          )
        );
      }
    );
  }
}



