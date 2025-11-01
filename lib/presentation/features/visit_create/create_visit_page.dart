import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/repositories/providers.dart';
import '../../features/visits/visits_controller.dart';
import '../../../domain/entities/equipment.dart';
import '../../features/auth/role_controller.dart';

class CreateVisitPage extends ConsumerStatefulWidget {
  const CreateVisitPage({super.key});

  @override
  ConsumerState<CreateVisitPage> createState() => _CreateVisitPageState();
}

class _CreateVisitPageState extends ConsumerState<CreateVisitPage> {
  final _codeCtrl = TextEditingController();
  Equipment? _equipment;
  bool _loading = false;

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _lookup() async {
    final code = _codeCtrl.text.trim();
    if (code.isEmpty) {
      setState(() => _equipment = null);
      return;
    }
    setState(() => _loading = true);
    final ds = ref.read(equipmentCatalogProvider);
    final eq = await ds.getByCode(code);
    if (!mounted) return;
    setState(() {
      _equipment = eq;
      _loading = false;
    });
  }

  Future<void> _save() async {
    final code = _codeCtrl.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un código para continuar.')),
      );
      return;
    }
    await ref.read(visitsControllerProvider.notifier).addVisitWithCode(code);
    if (!mounted) return;
    context.pop(); // volver a la lista
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Visita registrada.')));
  }

  @override
  Widget build(BuildContext context) {
    // Si no hay rol (deep link, etc.), reenvía a selección
    final role = ref.watch(userRoleProvider);
    if (role == null) {
      Future.microtask(() {
        if (context.mounted) context.go('/role');
      });
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar visita')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Simulación de escaneo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _codeCtrl,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Código del equipo (p.ej., EQP-101)',
              hintText: 'EQP-101',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                tooltip: 'Buscar info',
                onPressed: _lookup,
                icon: const Icon(Icons.search),
              ),
            ),
            onSubmitted: (_) => _lookup(),
          ),
          const SizedBox(height: 12),
          if (_loading) const Center(child: CircularProgressIndicator()),
          if (!_loading && _equipment != null)
            _EquipmentCard(equipment: _equipment!),
          if (!_loading && _equipment == null && _codeCtrl.text.isNotEmpty)
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Equipo no encontrado'),
                subtitle: Text(
                  'No hay información simulada para “${_codeCtrl.text}”. '
                  'Aún puedes guardar la visita.',
                ),
              ),
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check),
            label: const Text('Guardar visita'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              // Autocompletar un código válido del mock para rapidez
              setState(() {
                _codeCtrl.text =
                    'EQP-10${[1, 2, 3]
                      ..shuffle()
                      ..first}';
                _equipment = null;
              });
            },
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Simular código'),
          ),
          const SizedBox(height: 8),
          Text(
            'Nota: esta pantalla simula un escaneo. '
            'En la siguiente fase incorporaremos el escáner real y la geolocalización.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _EquipmentCard extends StatelessWidget {
  final Equipment equipment;
  const _EquipmentCard({required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.precision_manufacturing),
        title: Text('${equipment.code} — ${equipment.name}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (equipment.area != null) Text('Área: ${equipment.area}'),
            if (equipment.status != null) Text('Estado: ${equipment.status}'),
          ],
        ),
      ),
    );
  }
}
