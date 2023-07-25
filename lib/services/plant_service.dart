import 'package:flutter/material.dart';
import '../models/plant_model.dart';

class PlantService {
  List<Plant> _plants = [];

  List<Plant> get allPlants => _plants;

  void addPlant(Plant plant) {
    _plants.add(plant);
    debugPrint('Plant added: ${plant.name}');
  }

  void deletePlant(String id) {
    _plants.removeWhere((plant) => plant.id == id);
  }

  Plant getPlant(String id) {
    return _plants.firstWhere((plant) => plant.id == id);
  }

  void waterPlant(String id) {
    int index = _plants.indexWhere((plant) => plant.id == id);
    if (index != -1) {
      Plant plant = _plants[index];
      plant.nextWateringTime = DateTime.now().add(plant.wateringFrequency);
    }
  }
}
