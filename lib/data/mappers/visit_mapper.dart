import 'package:drift/drift.dart' show Value;
import '../../domain/entities/visit.dart';
import '../datasources/local/app_database.dart';

extension DbVisitToDomain on DbVisit {
  Visit toDomain() => Visit(
    id: id,
    code: code,
    technicianId: technicianId,
    timestamp: timestamp,
    lat: lat,
    lng: lng,
  );
}

extension VisitToCompanion on Visit {
  DbVisitsCompanion toCompanion() => DbVisitsCompanion(
    id: Value(id),
    code: Value(code),
    technicianId: Value(technicianId),
    timestamp: Value(timestamp),
    lat: Value(lat),
    lng: Value(lng),
  );
}
