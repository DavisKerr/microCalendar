import 'dart:convert';

import 'package:micro_calendar/Actions/api_actions.dart';
import 'package:micro_calendar/Actions/db_actions.dart';
import 'package:micro_calendar/Database/db_helper.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import '../State/app_state.dart';

Future <String> prepData() async {
  String json = "";
  List<Map<String, dynamic>> goals = await DBHelper.getAllGoals();
  List<Map<String, dynamic>> progress = await DBHelper.getAllProgress();
  List<Map<String, dynamic>> jsonGoal;
  for(int i = 0; i < goals.length; i++) {
    String progressJson = "";
    for(int j = 0; j < progress.length; j++) {
      progressJson += '''{"goalUuid" : "${goals[i]["goal_uuid"]}",
        "uuid" : "${progress[j]["progress_uuid"]}",
        "units" : ${progress[j]["progress_units"]},
        "testData" : ${progress[j]["progress_is_test_data"]},
        "deleted" : ${progress[j]["progress_deleted"]},
        "dateString" : "${progress[j]["progress_date"]}"},''';
    }
  if(progressJson.length > 1)
  {
    progressJson = progressJson.substring(0, progressJson.length - 1);
  }
  
   json += '''{
    "goal" : {
      "uuid": "${goals[i]["goal_uuid"]}",
        "name": "${goals[i]["goal_name"]}",
        "verb": "${goals[i]["goal_verb"]}",
        "measurement": "${goals[i]["goal_units"]}",
        "quantity": ${goals[i]["goal_quantity"]},
        "period": ${goals[i]["goal_period"]},
        "startDate": "${goals[i]["goal_start_date"]}",
        "endDate": "${goals[i]["goal_end_date"]}",
        "completed": ${goals[i]["goal_completed"]},
        "dateCreated": "${goals[i]["goal_date_created"]}",
        "isTestData": ${goals[i]["goal_is_test_data"]},
        "deleted": ${goals[i]["goal_deleted"]}
      },
    "progress" : [$progressJson]},''';
  }
  if(json.length > 1) {
      json = json.substring(0, json.length - 1);
    }
  print("[" + json + "]");
  return "[" + json + "]";
  
}

 Future <List<dynamic>> sync(String token)  async {

  String data = await prepData();
  http.Response res = await http.post(
      Uri.parse('http://microapi-env-1.eba-pkkv9t8c.us-west-2.elasticbeanstalk.com/goals'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : token
      },
      body: data
  );

  return jsonDecode(res.body);
  
 }

void apiMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next
) {
  
  if(action is SyncApiAttemptAction) {
    sync(action.token).then((data) => store.dispatch(InsertDataFromJSONAction(data)));
  }

  next(action);
}