

import 'package:flutter_test/flutter_test.dart';
import 'package:micro_calendar/Database/db_helper.dart';
import 'package:time_machine/time_machine.dart';

import '../lib/Model/goal.dart';
import '../lib/Reducers/Reducer.dart';


void main() 
{
  group('DB', () {
    test('DB', () {
      DBHelper.database().then((db) => db.rawQuery("SELECT * FROM goal_table").then((res) => print(res)));
      expect(0, equals(0));
    });
  });
  group('Integer', () {
    test('getNumCompletePeriods gets the correct number for a week of daily goals', () {
      DateTime start = DateTime.parse("2022-10-22 00:00:00");
      DateTime end = DateTime.parse("2022-10-29 00:00:00");
      PeriodUnit period = PeriodUnit.day;
      expect(getNumCompletePeriods(start, end, period), equals(7));
    });
  });

  group('Integer', () {
    test('getNumCompletePeriods gets the correct number for a week of daily goals', () {
      DateTime start = DateTime.parse("2022-10-22 00:00:00");
      DateTime end = DateTime.parse("2022-10-29 00:00:00");
      PeriodUnit period = PeriodUnit.day;
      expect(getNumCompletePeriods(start, end, period), equals(7));
    });
  });

  group('Integer', () {
    test('getNumCompletePeriods gets the correct number for goals with weekly periods', () {
      DateTime start = DateTime.parse("2022-10-22 00:00:00");
      DateTime end = DateTime.parse("2022-10-29 00:00:00");
      PeriodUnit period = PeriodUnit.week;
      expect(getNumCompletePeriods(start, end, period), equals(1));
    });
  });

    group('Integer', () {
    test('getNumCompletePeriods gets the correct number for goals with weekly periods for not full weeks', () {
      DateTime start = DateTime.parse("2022-10-22 00:00:00");
      DateTime end = DateTime.parse("2022-11-16 00:00:00");
      PeriodUnit period = PeriodUnit.week;
      expect(getNumCompletePeriods(start, end, period), equals(4));
    });
  });

  group('Integer', () {
    test('getNumCompletePeriods gets the correct number for the testState data', () {
      DateTime start = DateTime.parse("2022-04-20 00:00:00");
      DateTime end = DateTime.parse("2022-12-15 00:00:00");
      PeriodUnit period = PeriodUnit.day;
      expect(getNumCompletePeriods(start, end, period), equals(239));
    });
  });

  group('Integer', () {
    test('getNext Period gets the correct number for the first period', () {
      DateTime start = DateTime.parse("2022-10-22 00:00:00");
      DateTime event = DateTime.parse("2022-10-22 23:00:00");
      PeriodUnit period = PeriodUnit.day;
      expect(getNextPeriod(start, event, period), equals(0));
    });
  });

  group('Integer', () {
    test('getNext Period gets the correct number for the 7th period', () {
      DateTime start = DateTime.parse("2022-10-22 00:00:00");
      DateTime event = DateTime.parse("2022-10-29 23:00:00");
      PeriodUnit period = PeriodUnit.day;
      expect(getNextPeriod(start, event, period), equals(7));
    });
  });
}