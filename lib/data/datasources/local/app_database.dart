// lib/data/datasources/local/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class DbVisits extends Table {
  TextColumn get id => text()(); // PK
  TextColumn get code => text()(); // Código escaneado
  TextColumn get technicianId => text()(); // Dueño del registro
  DateTimeColumn get timestamp => dateTime()(); // Fecha/hora
  RealColumn get lat => real().nullable()(); // GPS (futuro)
  RealColumn get lng => real().nullable()(); // GPS (futuro)

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [DbVisits])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.sqlite'));
    // Usamos NativeDatabase en background para no bloquear el UI thread.
    return NativeDatabase.createInBackground(file);
  });
}

// ------------ DAO (consultas tipadas) ------------
@DriftAccessor(tables: [DbVisits])
class VisitDao extends DatabaseAccessor<AppDatabase> with _$VisitDaoMixin {
  VisitDao(AppDatabase db) : super(db);

  Future<List<DbVisit>> listAllDesc() {
    return (select(
      dbVisits,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).get();
  }

  Future<List<DbVisit>> listByTechnicianDesc(String techId) {
    return (select(dbVisits)
          ..where((t) => t.technicianId.equals(techId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  Future<int> insertVisit(Insertable<DbVisit> companion) =>
      into(dbVisits).insert(companion);

  Future<int> clearAll() => delete(dbVisits).go();
}
