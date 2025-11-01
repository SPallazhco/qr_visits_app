import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'inmemory_visit_repository.dart';
import '../../domain/repositories/visit_repository.dart';

final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  // Instancia única durante el ciclo de vida de la app
  return InMemoryVisitRepository();
});
