import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/user_role.dart';

final userRoleProvider = StateNotifierProvider<UserRoleController, UserRole?>(
  (ref) => UserRoleController(),
);

class UserRoleController extends StateNotifier<UserRole?> {
  UserRoleController() : super(null);

  void select(UserRole role) {
    state = role;
  }

  void clear() {
    state = null;
  }
}
