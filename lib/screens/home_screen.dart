import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/plant_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Plants'),
      ),
      body: StreamBuilder<List<Plant>>(
        stream: plantService.plantsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final plants = snapshot.data!;
            return ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];
                return PlantCard(
                  plant: plant,
                  deletePlant: plantService.deletePlant,
                  waterPlant: plantService.waterPlant,
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'You have no plants. Start adding some!',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        },
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
