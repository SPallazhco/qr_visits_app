import 'package:flutter/material.dart';
import '../../../../domain/entities/visit.dart';

class VisitTile extends StatelessWidget {
  final Visit visit;
  const VisitTile({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    final ts = visit.timestamp;
    final tsStr =
        '${ts.year.toString().padLeft(4, '0')}-${ts.month.toString().padLeft(2, '0')}-${ts.day.toString().padLeft(2, '0')} '
        '${ts.hour.toString().padLeft(2, '0')}:${ts.minute.toString().padLeft(2, '0')}';

    return ListTile(
      leading: const Icon(Icons.qr_code_2),
      title: Text(visit.code),
      subtitle: Text('Técnico: ${visit.technicianId}\n$tsStr'),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Más adelante: detalle de visita
      },
    );
  }
}
