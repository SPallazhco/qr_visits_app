import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/role_controller.dart';
import '../../../domain/entities/user_role.dart';

class VisitsListPage extends ConsumerWidget {
  const VisitsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);

    // Si no hay rol, redirigimos a selección de rol
    if (role == null) {
      // Usamos Future.microtask para no romper el build
      Future.microtask(() {
        context.go('/role');
      });
      return const SizedBox.shrink();
    }

    final title = role == UserRole.technician
        ? 'Mis visitas'
        : 'Visitas (todos)';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Cambiar rol',
            onPressed: () {
              // Limpiamos rol y volvemos a selección
              ref.read(userRoleProvider.notifier).clear();
              context.go('/role');
            },
            icon: const Icon(Icons.switch_account),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Aquí verás el listado de visitas (${role.label}).\n'
            'Hoy solo es esqueleto; mañana añadimos persistencia y escáner.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Placeholder: más adelante abrirá scanner / crear visita
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Aquí abrirá el escáner (próximo paso).'),
            ),
          );
        },
        label: const Text('Registrar visita'),
        icon: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
