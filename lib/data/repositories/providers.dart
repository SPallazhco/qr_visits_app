import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/local/app_database.dart';
import '../../domain/repositories/visit_repository.dart';
import 'drift_visit_repository.dart';
import '../datasources/equipment_local_data_source.dart';

// Base de datos (unica instancia)
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// DAO de equipos mock (assets)
final equipmentCatalogProvider = Provider<EquipmentLocalDataSource>((ref) {
  return EquipmentLocalDataSource();
});

// Repositorio de visitas (Drift + SQLite)
final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftVisitRepository(db);
});
