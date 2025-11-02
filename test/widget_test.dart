import 'package:flutter_test/flutter_test.dart';
import 'package:qr_visits_app/data/datasources/local/app_database.dart';
import 'package:qr_visits_app/data/repositories/drift_visit_repository.dart';
import 'package:qr_visits_app/domain/entities/visit.dart';

void main() {
  late AppDatabase db;
  late DriftVisitRepository repo;

  Visit makeVisit({
    required String id,
    required String code,
    required String tech,
    required DateTime ts,
    double? lat,
    double? lng,
  }) {
    return Visit(
      id: id,
      code: code,
      technicianId: tech,
      timestamp: ts,
      lat: lat,
      lng: lng,
    );
  }

  setUp(() {
    db = AppDatabase.memory();
    repo = DriftVisitRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('listAll() ordena por timestamp DESC', () async {
    final v1 = makeVisit(
      id: 'v1',
      code: 'EQP-101',
      tech: 'T',
      ts: DateTime(2025, 1, 1, 10, 0),
    );
    final v2 = makeVisit(
      id: 'v2',
      code: 'EQP-202',
      tech: 'T',
      ts: DateTime(2025, 1, 1, 11, 0),
    );
    await repo.add(v1);
    await repo.add(v2);

    final all = await repo.listAll();
    expect(all.length, 2);
    expect(all.first.id, 'v2'); // más reciente primero
    expect(all.last.id, 'v1');
  });

  test('listByTechnician() filtra correctamente', () async {
    await repo.add(
      makeVisit(id: 'a', code: 'EQP-1', tech: 'A', ts: DateTime(2025, 1, 1, 9)),
    );
    await repo.add(
      makeVisit(
        id: 'b',
        code: 'EQP-2',
        tech: 'B',
        ts: DateTime(2025, 1, 1, 10),
      ),
    );
    await repo.add(
      makeVisit(
        id: 'c',
        code: 'EQP-3',
        tech: 'A',
        ts: DateTime(2025, 1, 1, 11),
      ),
    );

    final onlyA = await repo.listByTechnician('A');
    expect(onlyA.map((v) => v.id).toList(), ['c', 'a']); // DESC por fecha
  });

  test('clearAll() limpia la tabla', () async {
    await repo.add(
      makeVisit(
        id: 'x',
        code: 'EQP-X',
        tech: 'T',
        ts: DateTime(2025, 1, 1, 12),
      ),
    );
    expect((await repo.listAll()).length, 1);
    await repo.clearAll();
    expect((await repo.listAll()).length, 0);
  });
}
