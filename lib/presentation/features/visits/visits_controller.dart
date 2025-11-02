import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/visit.dart';
import '../../features/auth/role_controller.dart';
import '../../../domain/entities/user_role.dart';
import '../../../data/repositories/providers.dart';
import '../../../core/constants.dart';

final visitsControllerProvider =
    AutoDisposeAsyncNotifierProvider<VisitsController, List<Visit>>(
      VisitsController.new,
    );

class VisitsController extends AutoDisposeAsyncNotifier<List<Visit>> {
  @override
  Future<List<Visit>> build() async {
    final repo = ref.read(visitRepositoryProvider);

    // Reaccionar a cambios de rol: si cambia, reconstruimos
    final role = ref.watch(userRoleProvider);

    if (role == null) {
      // Sin rol => lista vacía
      return [];
    } else if (role == UserRole.supervisor) {
      return repo.listAll();
    } else {
      return repo.listByTechnician(kCurrentTechnicianId);
    }
  }

  Future<void> addVisitWithCode(String code, {double? lat, double? lng}) async {
    if (code.trim().isEmpty) return;
    final now = DateTime.now();
    final visit = Visit(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      code: code.trim(),
      technicianId: kCurrentTechnicianId,
      timestamp: now,
      lat: lat,
      lng: lng,
    );
    // Leer el repo directamente del provider para evitar LateInitializationError
    final repo = ref.read(visitRepositoryProvider);
    await repo.add(visit);
    await refresh();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
