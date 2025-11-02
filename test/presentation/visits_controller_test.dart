import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_visits_app/core/constants.dart';
import 'package:qr_visits_app/data/datasources/local/app_database.dart';
import 'package:qr_visits_app/data/repositories/drift_visit_repository.dart';
import 'package:qr_visits_app/data/repositories/providers.dart';
import 'package:qr_visits_app/domain/entities/visit.dart';
import 'package:qr_visits_app/domain/entities/user_role.dart';
import 'package:qr_visits_app/presentation/features/auth/role_controller.dart';
import 'package:qr_visits_app/presentation/features/visits/visits_controller.dart';

void main() {
  late ProviderContainer container;

  Visit v(String id, String code, String tech, DateTime ts) =>
      Visit(id: id, code: code, technicianId: tech, timestamp: ts);

  setUp(() {
    container = ProviderContainer(
      overrides: [
        // DB en memoria para pruebas
        appDatabaseProvider.overrideWith((ref) => AppDatabase.memory()),
        // Repo basado en la DB de arriba
        visitRepositoryProvider.overrideWith((ref) {
          final db = ref.watch(appDatabaseProvider);
          return DriftVisitRepository(db);
        }),
      ],
    );
  });

  tearDown(() async {
    await container.read(appDatabaseProvider).close();
    container.dispose();
  });

  test('Technician ve sólo sus visitas; Supervisor ve todas', () async {
    final repo = container.read(visitRepositoryProvider);

    // Datos iniciales
    await repo.add(
      v('a', 'EQP-1', kCurrentTechnicianId, DateTime(2025, 1, 1, 9)),
    );
    await repo.add(v('b', 'EQP-2', 'other-tech', DateTime(2025, 1, 1, 10)));
    await repo.add(
      v('c', 'EQP-3', kCurrentTechnicianId, DateTime(2025, 1, 1, 11)),
    );

    final roleCtrl = container.read(userRoleProvider.notifier);
    final visitsCtrl = container.read(visitsControllerProvider.notifier);

    // Caso: TECHNICIAN
    roleCtrl.state =
        UserRole.technician; // Forzamos estado sin tocar persistencia
    await visitsCtrl.refresh();
    final techList = await container.read(visitsControllerProvider.future);
    expect(techList.length, 2);
    expect(techList.map((e) => e.id).toList(), ['c', 'a']); // DESC

    // Caso: SUPERVISOR
    roleCtrl.state = UserRole.supervisor;
    await visitsCtrl.refresh();
    final allList = await container.read(visitsControllerProvider.future);
    expect(allList.length, 3);
    expect(allList.map((e) => e.id).toList(), ['c', 'b', 'a']); // DESC
  });
}
