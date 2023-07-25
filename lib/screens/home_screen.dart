import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/plant_service.dart';
import '../widgets/plant_card.dart';
import '../screens/add_plant_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final plantService = GetIt.I<PlantService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Plants'),
      ),
      body: ListView.builder(
        itemCount: plantService.allPlants.length,
        itemBuilder: (context, index) {
          return PlantCard(plant: plantService.allPlants[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newPlant = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPlantScreen()),
          );

          if (newPlant != null) {
            setState(() {});
          }
        },
      ),
    );
  }
}