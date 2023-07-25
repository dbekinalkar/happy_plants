import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import '../services/plant_service.dart';
import '../services/notification_service.dart';
import '../models/plant_model.dart';

class AddPlantScreen extends StatefulWidget {
  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final plantService = GetIt.I<PlantService>();
  final notificationService = GetIt.I<NotificationService>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _waterAmountController = TextEditingController();
  final _wateringFrequencyController = TextEditingController();
  final uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plant'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Plant Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _waterAmountController,
                decoration: const InputDecoration(
                  labelText: 'Water Amount (L)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the water amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _wateringFrequencyController,
                decoration: const InputDecoration(
                  labelText: 'Watering Frequency (days)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the watering frequency';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save plant
                    final newPlant = Plant(
                      id: uuid.v1(),
                      name: _nameController.text,
                      waterAmount: double.parse(_waterAmountController.text),
                      wateringFrequency: Duration(
                          days: int.parse(_wateringFrequencyController.text)),
                      nextWateringTime: DateTime.now().add(Duration(
                          days: int.parse(_wateringFrequencyController.text))),
                    );
                    plantService.addPlant(newPlant);
                    notificationService.scheduleNotification(newPlant);

                    // Return new plant
                    Navigator.pop(context, newPlant);
                  }
                },
                child: const Text('Save'),
              ),
              /*IconButton(
                  onPressed: () {
                    Plant plant = Plant(
                      id: uuid.v1(),
                      name: "Test Plant",
                      waterAmount: 1,
                      wateringFrequency: const Duration(
                        minutes: 2,
                      ),
                      nextWateringTime: DateTime.now().add(const Duration(
                        minutes: 2,
                      )),
                    );

                    plantService.addPlant(plant);
                    notificationService.scheduleNotification(plant);

                    Navigator.pop(context, plant);
                  },
                  icon: const Icon(Icons.quiz)
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
