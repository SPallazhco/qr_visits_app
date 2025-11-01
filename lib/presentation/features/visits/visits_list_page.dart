import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/role_controller.dart';
import '../../../domain/entities/user_role.dart';
import 'visits_controller.dart';
import 'widgets/visit_tile.dart';

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
    final visitsAsync = ref.watch(visitsControllerProvider);

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
      body: visitsAsync.when(
        data: (visits) {
          if (visits.isEmpty) {
            return RefreshIndicator(
              onRefresh: () =>
                  ref.read(visitsControllerProvider.notifier).refresh(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('No hay visitas registradas.')),
                  SizedBox(height: 12),
                  Center(
                    child: Text('Pulsa “Registrar visita” para agregar una.'),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(visitsControllerProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 8, bottom: 88),
              itemCount: visits.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) => VisitTile(visit: visits[index]),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => RefreshIndicator(
          onRefresh: () =>
              ref.read(visitsControllerProvider.notifier).refresh(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 120),
              Center(child: Text('Ocurrió un error: $err')),
              const SizedBox(height: 12),
              const Center(child: Text('Desliza hacia abajo para reintentar.')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await ref.read(visitsControllerProvider.notifier).addQuickVisit();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Visita simulada agregada.')),
            );
          }
        },
        label: const Text('Registrar visita'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
