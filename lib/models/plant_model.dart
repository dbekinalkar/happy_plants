class Plant {
  final String id;
  final String name;
  final Duration wateringFrequency;
  DateTime nextWateringTime;

  Plant({
    required this.id,
    required this.name,
    required this.wateringFrequency,
  }) : nextWateringTime = DateTime.now().add(wateringFrequency);

  // Convert a Plant object into a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'wateringFrequency': wateringFrequency.inMilliseconds,
        'nextWateringTime': nextWateringTime.toIso8601String(),
      };

  // Create a Plant object from a map
  factory Plant.fromJson(Map<String, dynamic> json) {
    final plant = Plant(
      id: json['id'] as String,
      name: json['name'] as String,
      wateringFrequency:
          Duration(milliseconds: json['wateringFrequency'] as int),
    );
    plant.nextWateringTime = DateTime.parse(json['nextWateringTime'] as String);
    return plant;
  }
}
