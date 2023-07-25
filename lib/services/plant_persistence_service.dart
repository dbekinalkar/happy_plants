
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/plant_model.dart';

class PlantPersistenceService {
  Future<void> storePlants(List<Plant> plants) async {
    List<String> plantJsonList = plants.map((plant) => jsonEncode(plant.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('plants', plantJsonList);
  }

  Future<List<Plant>> loadPlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? plantJsonList = prefs.getStringList('plants');
    if (plantJsonList == null) {
      return [];
    } else {
      return plantJsonList.map((plantJson) => Plant.fromJson(jsonDecode(plantJson))).toList();
    }
  }
}
