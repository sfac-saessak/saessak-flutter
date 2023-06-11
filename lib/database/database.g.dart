// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ScheduleTable extends Schedule
    with TableInfo<$ScheduleTable, ScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
      'day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
      'time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _plantMeta = const VerificationMeta('plant');
  @override
  late final GeneratedColumn<String> plant = GeneratedColumn<String>(
      'plant', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isExecutedMeta =
      const VerificationMeta('isExecuted');
  @override
  late final GeneratedColumn<bool> isExecuted =
      GeneratedColumn<bool>('is_executed', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_executed" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _userUidMeta =
      const VerificationMeta('userUid');
  @override
  late final GeneratedColumn<String> userUid = GeneratedColumn<String>(
      'user_uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDoNotifyMeta =
      const VerificationMeta('isDoNotify');
  @override
  late final GeneratedColumn<bool> isDoNotify =
      GeneratedColumn<bool>('is_do_notify', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_do_notify" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        year,
        month,
        day,
        time,
        plant,
        content,
        isExecuted,
        userUid,
        isDoNotify
      ];
  @override
  String get aliasedName => _alias ?? 'schedule';
  @override
  String get actualTableName => 'schedule';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('plant')) {
      context.handle(
          _plantMeta, plant.isAcceptableOrUnknown(data['plant']!, _plantMeta));
    } else if (isInserting) {
      context.missing(_plantMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_executed')) {
      context.handle(
          _isExecutedMeta,
          isExecuted.isAcceptableOrUnknown(
              data['is_executed']!, _isExecutedMeta));
    } else if (isInserting) {
      context.missing(_isExecutedMeta);
    }
    if (data.containsKey('user_uid')) {
      context.handle(_userUidMeta,
          userUid.isAcceptableOrUnknown(data['user_uid']!, _userUidMeta));
    } else if (isInserting) {
      context.missing(_userUidMeta);
    }
    if (data.containsKey('is_do_notify')) {
      context.handle(
          _isDoNotifyMeta,
          isDoNotify.isAcceptableOrUnknown(
              data['is_do_notify']!, _isDoNotifyMeta));
    } else if (isInserting) {
      context.missing(_isDoNotifyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      day: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time'])!,
      plant: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plant'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      isExecuted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_executed'])!,
      userUid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_uid'])!,
      isDoNotify: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_do_notify'])!,
    );
  }

  @override
  $ScheduleTable createAlias(String alias) {
    return $ScheduleTable(attachedDatabase, alias);
  }
}

class ScheduleData extends DataClass implements Insertable<ScheduleData> {
  final int id;
  final int year;
  final int month;
  final int day;
  final int time;
  final String plant;
  final String content;
  final bool isExecuted;
  final String userUid;
  final bool isDoNotify;
  const ScheduleData(
      {required this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.time,
      required this.plant,
      required this.content,
      required this.isExecuted,
      required this.userUid,
      required this.isDoNotify});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['day'] = Variable<int>(day);
    map['time'] = Variable<int>(time);
    map['plant'] = Variable<String>(plant);
    map['content'] = Variable<String>(content);
    map['is_executed'] = Variable<bool>(isExecuted);
    map['user_uid'] = Variable<String>(userUid);
    map['is_do_notify'] = Variable<bool>(isDoNotify);
    return map;
  }

  ScheduleCompanion toCompanion(bool nullToAbsent) {
    return ScheduleCompanion(
      id: Value(id),
      year: Value(year),
      month: Value(month),
      day: Value(day),
      time: Value(time),
      plant: Value(plant),
      content: Value(content),
      isExecuted: Value(isExecuted),
      userUid: Value(userUid),
      isDoNotify: Value(isDoNotify),
    );
  }

  factory ScheduleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleData(
      id: serializer.fromJson<int>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      day: serializer.fromJson<int>(json['day']),
      time: serializer.fromJson<int>(json['time']),
      plant: serializer.fromJson<String>(json['plant']),
      content: serializer.fromJson<String>(json['content']),
      isExecuted: serializer.fromJson<bool>(json['isExecuted']),
      userUid: serializer.fromJson<String>(json['userUid']),
      isDoNotify: serializer.fromJson<bool>(json['isDoNotify']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'day': serializer.toJson<int>(day),
      'time': serializer.toJson<int>(time),
      'plant': serializer.toJson<String>(plant),
      'content': serializer.toJson<String>(content),
      'isExecuted': serializer.toJson<bool>(isExecuted),
      'userUid': serializer.toJson<String>(userUid),
      'isDoNotify': serializer.toJson<bool>(isDoNotify),
    };
  }

  ScheduleData copyWith(
          {int? id,
          int? year,
          int? month,
          int? day,
          int? time,
          String? plant,
          String? content,
          bool? isExecuted,
          String? userUid,
          bool? isDoNotify}) =>
      ScheduleData(
        id: id ?? this.id,
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        time: time ?? this.time,
        plant: plant ?? this.plant,
        content: content ?? this.content,
        isExecuted: isExecuted ?? this.isExecuted,
        userUid: userUid ?? this.userUid,
        isDoNotify: isDoNotify ?? this.isDoNotify,
      );
  @override
  String toString() {
    return (StringBuffer('ScheduleData(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('time: $time, ')
          ..write('plant: $plant, ')
          ..write('content: $content, ')
          ..write('isExecuted: $isExecuted, ')
          ..write('userUid: $userUid, ')
          ..write('isDoNotify: $isDoNotify')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, year, month, day, time, plant, content,
      isExecuted, userUid, isDoNotify);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleData &&
          other.id == this.id &&
          other.year == this.year &&
          other.month == this.month &&
          other.day == this.day &&
          other.time == this.time &&
          other.plant == this.plant &&
          other.content == this.content &&
          other.isExecuted == this.isExecuted &&
          other.userUid == this.userUid &&
          other.isDoNotify == this.isDoNotify);
}

class ScheduleCompanion extends UpdateCompanion<ScheduleData> {
  final Value<int> id;
  final Value<int> year;
  final Value<int> month;
  final Value<int> day;
  final Value<int> time;
  final Value<String> plant;
  final Value<String> content;
  final Value<bool> isExecuted;
  final Value<String> userUid;
  final Value<bool> isDoNotify;
  const ScheduleCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.day = const Value.absent(),
    this.time = const Value.absent(),
    this.plant = const Value.absent(),
    this.content = const Value.absent(),
    this.isExecuted = const Value.absent(),
    this.userUid = const Value.absent(),
    this.isDoNotify = const Value.absent(),
  });
  ScheduleCompanion.insert({
    this.id = const Value.absent(),
    required int year,
    required int month,
    required int day,
    required int time,
    required String plant,
    required String content,
    required bool isExecuted,
    required String userUid,
    required bool isDoNotify,
  })  : year = Value(year),
        month = Value(month),
        day = Value(day),
        time = Value(time),
        plant = Value(plant),
        content = Value(content),
        isExecuted = Value(isExecuted),
        userUid = Value(userUid),
        isDoNotify = Value(isDoNotify);
  static Insertable<ScheduleData> custom({
    Expression<int>? id,
    Expression<int>? year,
    Expression<int>? month,
    Expression<int>? day,
    Expression<int>? time,
    Expression<String>? plant,
    Expression<String>? content,
    Expression<bool>? isExecuted,
    Expression<String>? userUid,
    Expression<bool>? isDoNotify,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (day != null) 'day': day,
      if (time != null) 'time': time,
      if (plant != null) 'plant': plant,
      if (content != null) 'content': content,
      if (isExecuted != null) 'is_executed': isExecuted,
      if (userUid != null) 'user_uid': userUid,
      if (isDoNotify != null) 'is_do_notify': isDoNotify,
    });
  }

  ScheduleCompanion copyWith(
      {Value<int>? id,
      Value<int>? year,
      Value<int>? month,
      Value<int>? day,
      Value<int>? time,
      Value<String>? plant,
      Value<String>? content,
      Value<bool>? isExecuted,
      Value<String>? userUid,
      Value<bool>? isDoNotify}) {
    return ScheduleCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      time: time ?? this.time,
      plant: plant ?? this.plant,
      content: content ?? this.content,
      isExecuted: isExecuted ?? this.isExecuted,
      userUid: userUid ?? this.userUid,
      isDoNotify: isDoNotify ?? this.isDoNotify,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (plant.present) {
      map['plant'] = Variable<String>(plant.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isExecuted.present) {
      map['is_executed'] = Variable<bool>(isExecuted.value);
    }
    if (userUid.present) {
      map['user_uid'] = Variable<String>(userUid.value);
    }
    if (isDoNotify.present) {
      map['is_do_notify'] = Variable<bool>(isDoNotify.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('time: $time, ')
          ..write('plant: $plant, ')
          ..write('content: $content, ')
          ..write('isExecuted: $isExecuted, ')
          ..write('userUid: $userUid, ')
          ..write('isDoNotify: $isDoNotify')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $ScheduleTable schedule = $ScheduleTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [schedule];
}
