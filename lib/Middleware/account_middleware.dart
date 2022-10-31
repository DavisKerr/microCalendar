
// Future<Iterable<dynamic>> signInAttempt() => HttpClient()
// .getUrl(Uri.parse(url))
// .then((req) => req.close())
// .then((resp) => resp.transform(utf8.decoder).join())
// .then((str) => json.decode(str) as List<dynamic>)
// .then((list) => list.map((e) =>  SignInData.fromJson(e)));

import 'package:micro_calendar/Actions/account_actions.dart';
import 'package:micro_calendar/Actions/navigation_actions.dart';
import 'package:redux/redux.dart';

import '../State/app_state.dart';

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
    
    store.dispatch(
      SignInSuccessAccountAction(action.username),
    );
    store.dispatch(
      NavigateBackAction()
    );
  }
  // if (action is SignInAttemptAccountAction) {
  //   signInAttempt().then((items) {
  //     print(items);
  //     store.dispatch(SignInSuccessAccountAction(items.first.username));
  //     store.dispatch(NavigateBackAction());
  //   }).catchError((e) {
  //     store.dispatch(FailedToSignInAction(e));
  //   });
  // }

  next(action);
}