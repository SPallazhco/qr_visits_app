import '../entities/visit.dart';

abstract class VisitRepository {
  Future<List<Visit>> listAll();
  Future<List<Visit>> listByTechnician(String technicianId);
  Future<Visit> add(Visit visit);
  Future<void> clearAll();
}
