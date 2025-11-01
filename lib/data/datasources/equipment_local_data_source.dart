import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../domain/entities/equipment.dart';

class EquipmentLocalDataSource {
  List<Equipment>? _cache;

  Future<void> _ensureLoaded() async {
    if (_cache != null) return;
    final raw = await rootBundle.loadString('assets/mock/equipment.json');
    final List<dynamic> data = jsonDecode(raw) as List<dynamic>;
    _cache = data
        .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Equipment>> listAll() async {
    await _ensureLoaded();
    return List<Equipment>.unmodifiable(_cache!);
  }

  Future<Equipment?> getByCode(String code) async {
    await _ensureLoaded();
    try {
      return _cache!.firstWhere(
        (e) => e.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
