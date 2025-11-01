import 'dart:math';
import 'package:uuid/uuid.dart';
import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';
import '../../core/constants.dart';

class InMemoryVisitRepository implements VisitRepository {
  final _items = <Visit>[];
  bool _seeded = false;
  final _uuid = const Uuid();

  InMemoryVisitRepository() {
    _seedIfNeeded();
  }

  void _seedIfNeeded() {
    if (_seeded) return;
    _seeded = true;

    final now = DateTime.now();
    // Semillas: 2 del técnico actual y 1 de otro técnico
    _items.addAll([
      Visit(
        id: _uuid.v4(),
        code: 'EQP-101',
        technicianId: kCurrentTechnicianId,
        timestamp: now.subtract(const Duration(minutes: 20)),
      ),
      Visit(
        id: _uuid.v4(),
        code: 'EQP-202',
        technicianId: kCurrentTechnicianId,
        timestamp: now.subtract(const Duration(hours: 1, minutes: 5)),
      ),
      Visit(
        id: _uuid.v4(),
        code: 'EQP-303',
        technicianId: 'tech-XYZ',
        timestamp: now.subtract(const Duration(days: 1, minutes: 2)),
      ),
    ]);
    // Orden descendente por fecha
    _items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Future<List<Visit>> listAll() async {
    // Simular I/O
    await Future<void>.delayed(const Duration(milliseconds: 150));
    // Devolver copia para evitar mutaciones externas
    return List<Visit>.unmodifiable(_items);
  }

  @override
  Future<List<Visit>> listByTechnician(String technicianId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final filtered =
        _items.where((v) => v.technicianId == technicianId).toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return List<Visit>.unmodifiable(filtered);
  }

  @override
  Future<Visit> add(Visit visit) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    _items.add(visit);
    _items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return visit;
  }

  @override
  Future<void> clearAll() async {
    _items.clear();
  }

  /// Helper para crear rápidamente una visita "dummy"
  Future<Visit> addQuickVisit() async {
    final code = 'EQP-${100 + Random().nextInt(900)}';
    final visit = Visit(
      id: _uuid.v4(),
      code: code,
      technicianId: kCurrentTechnicianId,
      timestamp: DateTime.now(),
    );
    return add(visit);
  }
}
