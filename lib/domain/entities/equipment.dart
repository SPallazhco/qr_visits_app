class Equipment {
  final String code;
  final String name;
  final String? area;
  final String? status;

  const Equipment({
    required this.code,
    required this.name,
    this.area,
    this.status,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      code: json['code'] as String,
      name: json['name'] as String,
      area: json['area'] as String?,
      status: json['status'] as String?,
    );
  }
}
