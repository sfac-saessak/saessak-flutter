import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import '../model/schedule/schedule.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Schedule])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future createSchedule(ScheduleCompanion data) => into(schedule).insert(data); // 스케줄 만들기
  Future selectSchedule() => select(schedule).get(); // 스케줄 가져오기
  Future selectMonthSchedule(int month) => // 선택한 월 스케줄 가져오기
      (select(schedule)..where((tbl) => tbl.month.equals(month))).get();
  Future deleteAll() => delete(schedule).go(); // 전체 스케줄 삭제
  Future deleteSchedule(int id) => // 선택한 id의 단일 스케줄 가져오기
      (delete(schedule)..where((tbl) => tbl.id.equals(id))).go();
  Future updateSchedule(int id, ScheduleCompanion data) => // 업데이트
      (update(schedule)..where((tbl) => tbl.id.equals(id))).write(data);
  

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
