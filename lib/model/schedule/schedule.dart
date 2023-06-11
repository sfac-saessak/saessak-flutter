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
}


// 수정 전, 알림기능 구현시 활용
// class Schedule extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get year => integer()();
//   IntColumn get month => integer()();
//   IntColumn get day => integer()();
//   DateTimeColumn get time => dateTime()();
//   TextColumn get plant => text()();
//   TextColumn get content => text()();
//   BoolColumn get isExecuted => boolean()();
//   BoolColumn get isDoNotify => boolean()();
//   DateTimeColumn get notiTime => dateTime()();
// }