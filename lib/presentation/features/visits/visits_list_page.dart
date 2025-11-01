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

    if (role == null) {
      Future.microtask(() {
        if (context.mounted) context.go('/role');
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
            onPressed: () async {
              await ref.read(userRoleProvider.notifier).clear();
              if (context.mounted) context.go('/role');
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
            'Hoy: solo esqueleto. Próximo paso: entidad Visit + repo local.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
