// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DbVisitsTable extends DbVisits with TableInfo<$DbVisitsTable, DbVisit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbVisitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _technicianIdMeta = const VerificationMeta(
    'technicianId',
  );
  @override
  late final GeneratedColumn<String> technicianId = GeneratedColumn<String>(
    'technician_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    technicianId,
    timestamp,
    lat,
    lng,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_visits';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbVisit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('technician_id')) {
      context.handle(
        _technicianIdMeta,
        technicianId.isAcceptableOrUnknown(
          data['technician_id']!,
          _technicianIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_technicianIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbVisit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbVisit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      technicianId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      ),
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      ),
    );
  }

  @override
  $DbVisitsTable createAlias(String alias) {
    return $DbVisitsTable(attachedDatabase, alias);
  }
}

class DbVisit extends DataClass implements Insertable<DbVisit> {
  final String id;
  final String code;
  final String technicianId;
  final DateTime timestamp;
  final double? lat;
  final double? lng;
  const DbVisit({
    required this.id,
    required this.code,
    required this.technicianId,
    required this.timestamp,
    this.lat,
    this.lng,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['technician_id'] = Variable<String>(technicianId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lng != null) {
      map['lng'] = Variable<double>(lng);
    }
    return map;
  }

  DbVisitsCompanion toCompanion(bool nullToAbsent) {
    return DbVisitsCompanion(
      id: Value(id),
      code: Value(code),
      technicianId: Value(technicianId),
      timestamp: Value(timestamp),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lng: lng == null && nullToAbsent ? const Value.absent() : Value(lng),
    );
  }

  factory DbVisit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbVisit(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      technicianId: serializer.fromJson<String>(json['technicianId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      lat: serializer.fromJson<double?>(json['lat']),
      lng: serializer.fromJson<double?>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'technicianId': serializer.toJson<String>(technicianId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'lat': serializer.toJson<double?>(lat),
      'lng': serializer.toJson<double?>(lng),
    };
  }

  DbVisit copyWith({
    String? id,
    String? code,
    String? technicianId,
    DateTime? timestamp,
    Value<double?> lat = const Value.absent(),
    Value<double?> lng = const Value.absent(),
  }) => DbVisit(
    id: id ?? this.id,
    code: code ?? this.code,
    technicianId: technicianId ?? this.technicianId,
    timestamp: timestamp ?? this.timestamp,
    lat: lat.present ? lat.value : this.lat,
    lng: lng.present ? lng.value : this.lng,
  );
  DbVisit copyWithCompanion(DbVisitsCompanion data) {
    return DbVisit(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      technicianId: data.technicianId.present
          ? data.technicianId.value
          : this.technicianId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbVisit(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('technicianId: $technicianId, ')
          ..write('timestamp: $timestamp, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, technicianId, timestamp, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbVisit &&
          other.id == this.id &&
          other.code == this.code &&
          other.technicianId == this.technicianId &&
          other.timestamp == this.timestamp &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class DbVisitsCompanion extends UpdateCompanion<DbVisit> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> technicianId;
  final Value<DateTime> timestamp;
  final Value<double?> lat;
  final Value<double?> lng;
  final Value<int> rowid;
  const DbVisitsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.technicianId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbVisitsCompanion.insert({
    required String id,
    required String code,
    required String technicianId,
    required DateTime timestamp,
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       technicianId = Value(technicianId),
       timestamp = Value(timestamp);
  static Insertable<DbVisit> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? technicianId,
    Expression<DateTime>? timestamp,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (technicianId != null) 'technician_id': technicianId,
      if (timestamp != null) 'timestamp': timestamp,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbVisitsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? technicianId,
    Value<DateTime>? timestamp,
    Value<double?>? lat,
    Value<double?>? lng,
    Value<int>? rowid,
  }) {
    return DbVisitsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      technicianId: technicianId ?? this.technicianId,
      timestamp: timestamp ?? this.timestamp,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (technicianId.present) {
      map['technician_id'] = Variable<String>(technicianId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbVisitsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('technicianId: $technicianId, ')
          ..write('timestamp: $timestamp, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DbVisitsTable dbVisits = $DbVisitsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dbVisits];
}

typedef $$DbVisitsTableCreateCompanionBuilder =
    DbVisitsCompanion Function({
      required String id,
      required String code,
      required String technicianId,
      required DateTime timestamp,
      Value<double?> lat,
      Value<double?> lng,
      Value<int> rowid,
    });
typedef $$DbVisitsTableUpdateCompanionBuilder =
    DbVisitsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> technicianId,
      Value<DateTime> timestamp,
      Value<double?> lat,
      Value<double?> lng,
      Value<int> rowid,
    });

class $$DbVisitsTableFilterComposer
    extends Composer<_$AppDatabase, $DbVisitsTable> {
  $$DbVisitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technicianId => $composableBuilder(
    column: $table.technicianId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbVisitsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbVisitsTable> {
  $$DbVisitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicianId => $composableBuilder(
    column: $table.technicianId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbVisitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbVisitsTable> {
  $$DbVisitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get technicianId => $composableBuilder(
    column: $table.technicianId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);
}

class $$DbVisitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbVisitsTable,
          DbVisit,
          $$DbVisitsTableFilterComposer,
          $$DbVisitsTableOrderingComposer,
          $$DbVisitsTableAnnotationComposer,
          $$DbVisitsTableCreateCompanionBuilder,
          $$DbVisitsTableUpdateCompanionBuilder,
          (DbVisit, BaseReferences<_$AppDatabase, $DbVisitsTable, DbVisit>),
          DbVisit,
          PrefetchHooks Function()
        > {
  $$DbVisitsTableTableManager(_$AppDatabase db, $DbVisitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbVisitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbVisitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbVisitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> technicianId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lng = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbVisitsCompanion(
                id: id,
                code: code,
                technicianId: technicianId,
                timestamp: timestamp,
                lat: lat,
                lng: lng,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String technicianId,
                required DateTime timestamp,
                Value<double?> lat = const Value.absent(),
                Value<double?> lng = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbVisitsCompanion.insert(
                id: id,
                code: code,
                technicianId: technicianId,
                timestamp: timestamp,
                lat: lat,
                lng: lng,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbVisitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbVisitsTable,
      DbVisit,
      $$DbVisitsTableFilterComposer,
      $$DbVisitsTableOrderingComposer,
      $$DbVisitsTableAnnotationComposer,
      $$DbVisitsTableCreateCompanionBuilder,
      $$DbVisitsTableUpdateCompanionBuilder,
      (DbVisit, BaseReferences<_$AppDatabase, $DbVisitsTable, DbVisit>),
      DbVisit,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DbVisitsTableTableManager get dbVisits =>
      $$DbVisitsTableTableManager(_db, _db.dbVisits);
}

mixin _$VisitDaoMixin on DatabaseAccessor<AppDatabase> {
  $DbVisitsTable get dbVisits => attachedDatabase.dbVisits;
}
