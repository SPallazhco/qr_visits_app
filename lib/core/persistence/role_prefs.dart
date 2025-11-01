import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_role.dart';

class RolePrefs {
  static const _key = 'selected_role';

  static String _toString(UserRole role) {
    switch (role) {
      case UserRole.technician:
        return 'technician';
      case UserRole.supervisor:
        return 'supervisor';
    }
  }

  static UserRole? _fromString(String? value) {
    switch (value) {
      case 'technician':
        return UserRole.technician;
      case 'supervisor':
        return UserRole.supervisor;
      default:
        return null;
    }
  }

  static Future<void> save(UserRole role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _toString(role));
  }

  static Future<UserRole?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    return _fromString(value);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
