import '../models/plant_model.dart';
import '../services/plant_persistence_service.dart';
import 'package:get_it/get_it.dart';

class PlantService {
  final plantPersistenceService = GetIt.I<PlantPersistenceService>();

  List<Plant> _plants = [];

  List<Plant> get allPlants => _plants;

  PlantService() {
    loadPlants();
  }

  Future<void> loadPlants() async {
    _plants = await plantPersistenceService.loadPlants();
  }

  void addPlant(Plant plant) {
    _plants.add(plant);
    plantPersistenceService.storePlants(_plants);
  }

  void deletePlant(String id) {
    _plants.removeWhere((plant) => plant.id == id);
    plantPersistenceService.storePlants(_plants);
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
    plantPersistenceService.storePlants(_plants);
  }
}
