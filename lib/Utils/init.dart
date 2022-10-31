import 'package:micro_calendar/View/view_model.dart';

class Init {

  static Future initialize(ViewModel viewModel) async {
    await _loadData(viewModel);
  }

  static _loadData(ViewModel viewModel) async {
    //await viewModel.loadData();
  // print("starting loading Data");
  // await Future.delayed(Duration(seconds: 3));
  // print("finished loading Data");
  }
}