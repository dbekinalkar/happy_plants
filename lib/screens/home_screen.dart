import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/plant_service.dart';
import '../widgets/plant_card.dart';
import '../screens/add_plant_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final plantService = GetIt.I<PlantService>();

  @override
  Widget build(BuildContext context) {
    final plants = plantService.allPlants;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Plants'),
      ),
      body: plants.isNotEmpty
          ? ListView.builder(
              itemCount: plantService.allPlants.length,
              itemBuilder: (context, index) {
                return PlantCard(plant: plantService.allPlants[index]);
              },
            )
          : const Center(
              child: Text(
                'You have no plants. Start adding some!',
                style: TextStyle(fontSize: 20),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newPlant = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlantScreen()),
          );

          if (newPlant != null) {
            setState(() {});
          }
        },
      ),
    );
  }
}
