class Visit {
  final String id;
  final String code; // Código escaneado (por ahora simulado)
  final String technicianId; // Dueño de la visita (para filtrar por rol)
  final DateTime timestamp; // Fecha/hora de registro
  final double? lat; // Más adelante con geoloc
  final double? lng;

  const Visit({
    required this.id,
    required this.code,
    required this.technicianId,
    required this.timestamp,
    this.lat,
    this.lng,
  });

  Visit copyWith({
    String? id,
    String? code,
    String? technicianId,
    DateTime? timestamp,
    double? lat,
    double? lng,
  }) {
    return Visit(
      id: id ?? this.id,
      code: code ?? this.code,
      technicianId: technicianId ?? this.technicianId,
      timestamp: timestamp ?? this.timestamp,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
