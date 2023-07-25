import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import '../services/plant_service.dart';
import '../services/notification_service.dart';
import '../models/plant_model.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final plantService = GetIt.I<PlantService>();
  final notificationService = GetIt.I<NotificationService>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _wateringFrequencyController = TextEditingController();
  final uuid = const Uuid();
  IconData _selectedIcon = Icons.local_florist;
  Color _selectedColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    Widget _buildIconButton(IconData icon, Color color) {
      return Container(
        decoration: ShapeDecoration(
          color: color == _selectedColor ? Colors.grey[300] : Colors.white,
          shape: const CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: color,
            shadows: const <Shadow>[Shadow(color: Colors.black, blurRadius: 3)],
          ),
          onPressed: () {
            setState(() {
              _selectedIcon = icon;
              _selectedColor = color;
              debugPrint(
                  _selectedIcon.toString() + ' ' + _selectedColor.toString());
            });
          },
        ),
      );
    }

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
              Row(
                children: <Widget>[
                  _buildIconButton(_selectedIcon, Colors.red),
                  _buildIconButton(_selectedIcon, Colors.orange),
                  _buildIconButton(_selectedIcon, Colors.yellow[300]!),
                  _buildIconButton(_selectedIcon, Colors.green),
                  _buildIconButton(_selectedIcon, Colors.blue),
                  _buildIconButton(_selectedIcon, Colors.purple),
                ],
              ),
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
                controller: _wateringFrequencyController,
                decoration: const InputDecoration(
                  labelText: 'Watering Frequency (days)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the watering frequency';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
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
                      wateringFrequency: Duration(
                          days: int.parse(_wateringFrequencyController.text)),
                      icon: _selectedIcon,
                      color: _selectedColor,
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
