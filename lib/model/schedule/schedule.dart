import 'package:drift/drift.dart';

class Schedule extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  IntColumn get day => integer()();
  IntColumn get time => integer()();
  TextColumn get plant => text()();
  TextColumn get content => text()();
  BoolColumn get isExecuted => boolean()();
  TextColumn get userUid => text()();
  BoolColumn get isDoNotify => boolean()();
}

