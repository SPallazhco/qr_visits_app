import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/user_role.dart';
import 'role_controller.dart';

class RoleSelectionPage extends ConsumerWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roles = UserRole.values;

    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar rol')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: roles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final role = roles[index];
          return Card(
            child: ListTile(
              title: Text(role.label),
              subtitle: Text(
                role == UserRole.technician
                    ? 'Verás solo tus visitas'
                    : 'Verás todas las visitas',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ref.read(userRoleProvider.notifier).select(role);
                // Navegamos a la lista de visitas usando GoRouter
                context.go('/visits');
              },
            ),
          );
        },
      ),
    );
  }
}
