class Plant {
  String id;
  String name;
  double? waterAmount;
  Duration wateringFrequency;
  DateTime nextWateringTime;

  Plant({
    required this.id,
    required this.name,
    this.waterAmount,
    required this.wateringFrequency,
    required this.nextWateringTime,
  });
}
