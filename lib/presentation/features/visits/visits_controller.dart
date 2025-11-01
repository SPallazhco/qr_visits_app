import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/visit.dart';
import '../../../domain/repositories/visit_repository.dart';
import '../../features/auth/role_controller.dart';
import '../../../domain/entities/user_role.dart';
import '../../../data/repositories/providers.dart';
import '../../../core/constants.dart';

final visitsControllerProvider =
    AutoDisposeAsyncNotifierProvider<VisitsController, List<Visit>>(
      VisitsController.new,
    );

class VisitsController extends AutoDisposeAsyncNotifier<List<Visit>> {
  late final VisitRepository _repo;

  @override
  Future<List<Visit>> build() async {
    _repo = ref.read(visitRepositoryProvider);

    // Reaccionar a cambios de rol: si cambia, reconstruimos
    final role = ref.watch(userRoleProvider);

    if (role == null) {
      // Sin rol => lista vacía
      return [];
    } else if (role == UserRole.supervisor) {
      return _repo.listAll();
    } else {
      return _repo.listByTechnician(kCurrentTechnicianId);
    }
  }

  Future<void> addVisitWithCode(String code) async {
    if (code.trim().isEmpty) return;
    final now = DateTime.now();
    final visit = Visit(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      code: code.trim(),
      technicianId: kCurrentTechnicianId,
      timestamp: now,
    );
    await _repo.add(visit);
    await refresh();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
