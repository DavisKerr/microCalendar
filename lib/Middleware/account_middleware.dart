
// Future<Iterable<dynamic>> signInAttempt() => HttpClient()
// .getUrl(Uri.parse(url))
// .then((req) => req.close())
// .then((resp) => resp.transform(utf8.decoder).join())
// .then((str) => json.decode(str) as List<dynamic>)
// .then((list) => list.map((e) =>  SignInData.fromJson(e)));

import 'dart:convert';

import 'package:micro_calendar/Actions/account_actions.dart';
import 'package:micro_calendar/Actions/event_response_actions.dart';
import 'package:micro_calendar/Actions/navigation_actions.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import '../State/app_state.dart';

Future<http.Response> signInAttempt(SignInAttemptAccountAction action) async {
  return http.post(
    Uri.parse('http://microapi-env-1.eba-pkkv9t8c.us-west-2.elasticbeanstalk.com/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username' : action.username,
      'password' : action.password,
    }),
  );
} 

Future<http.Response> RegisterAttempt(RegisterAttemptAccountAction action) async {
  return http.post(
    Uri.parse('http://microapi-env-1.eba-pkkv9t8c.us-west-2.elasticbeanstalk.com/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username' : action.username,
      'password' : action.password
    }),
  );
} 

String processResponce(http.Response res) {
  if(res.statusCode == 200 && res.headers["authorization"] != null) {
    return res.headers["authorization"]!;
  }
  else {
    return "Error signing in!";
  }
  
}

/*
* This is a placeholder for when the Auth is implemented. 
*/
void accountMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next
) {
  if(action is SignInAttemptAccountAction)
  {
    signInAttempt(action)
    .then((res) => processResponce(res))
    .then((str) {
      if(str.startsWith("Error")) {
        store.dispatch(SignInFailAccountAction());
      }
      else if(str.startsWith("Bearer ")) {
        store.dispatch(SignInSuccessAccountAction(action.username, str));
        store.dispatch(NavigateBackAction());
      }
    });
    
  }
  if(action is RegisterAttemptAccountAction) {
    RegisterAttempt(action).then((res) {
      if(res.statusCode == 200) {
        store.dispatch(RegisterSuccessAccountAction());
        store.dispatch(NavigateBackAction());
        store.dispatch(ShowToastAction("Account created successfully!"));
      }
      else if(res.statusCode == 500 && jsonDecode(res.body)["message"] != null) {
        store.dispatch(RegisterFailAccountAction(jsonDecode(res.body)["message"]));
      }
      else {
        store.dispatch(RegisterFailAccountAction("Something went wrong!"));
      }

    });
  }
  

  next(action);
}