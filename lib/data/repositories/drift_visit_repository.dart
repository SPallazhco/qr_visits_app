import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';
import '../datasources/local/app_database.dart';
import '../mappers/visit_mapper.dart';

class DriftVisitRepository implements VisitRepository {
  final AppDatabase _db;
  late final VisitDao _dao;

  DriftVisitRepository(this._db) {
    _dao = VisitDao(_db);
  }

  @override
  Future<List<Visit>> listAll() async {
    final rows = await _dao.listAllDesc();
    return rows.map((r) => r.toDomain()).toList(growable: false);
  }

  @override
  Future<List<Visit>> listByTechnician(String technicianId) async {
    final rows = await _dao.listByTechnicianDesc(technicianId);
    return rows.map((r) => r.toDomain()).toList(growable: false);
  }

  @override
  Future<Visit> add(Visit visit) async {
    await _dao.insertVisit(visit.toCompanion());
    return visit;
  }

  @override
  Future<void> clearAll() async {
    await _dao.clearAll();
  }
}
