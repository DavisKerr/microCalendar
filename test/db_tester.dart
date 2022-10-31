import 'package:flutter_test/flutter_test.dart';
import 'package:micro_calendar/Database/db_helper.dart';

void main() 
{
  group('DB', () {
    test('DB', () {
      DBHelper.database().then((db) => db.rawQuery("SELECT * FROM goal_table").then((res) => print(res)));
      expect(0, equals(0));
    });
  });
  
}