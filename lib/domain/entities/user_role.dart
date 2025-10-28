enum UserRole { technician, supervisor }

extension UserRoleX on UserRole {
  String get label => switch (this) {
    UserRole.technician => 'Técnico',
    UserRole.supervisor => 'Supervisor',
  };
}
