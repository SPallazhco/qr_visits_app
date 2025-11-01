import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/user_role.dart';
import '../../../core/persistence/role_prefs.dart';

final userRoleProvider = StateNotifierProvider<UserRoleController, UserRole?>(
  (ref) => UserRoleController(),
);

class UserRoleController extends StateNotifier<UserRole?> {
  UserRoleController() : super(null);

  /// Llamado desde Splash para cargar el rol guardado
  Future<void> hydrateFromStorage() async {
    final loaded = await RolePrefs.load();
    state = loaded;
  }

  Future<void> select(UserRole role) async {
    state = role;
    await RolePrefs.save(role);
  }

  Future<void> clear() async {
    state = null;
    await RolePrefs.clear();
  }
}
