import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_visits_app/data/datasources/equipment_local_data_source.dart';
import 'inmemory_visit_repository.dart';
import '../../domain/repositories/visit_repository.dart';

final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  return InMemoryVisitRepository();
});

final equipmentCatalogProvider = Provider<EquipmentLocalDataSource>((ref) {
  return EquipmentLocalDataSource();
});
