import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';
import '../models/plant_model.dart';
import '../services/plant_service.dart';
import '../services/notification_service.dart';
import '../utils/utils.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  final plantService = GetIt.I<PlantService>();
  final notificationService = GetIt.I<NotificationService>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer t) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Plant Name: ${widget.plant.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16.0),
            Text('Watering Frequency: Every ${widget.plant.wateringFrequency.inDays} days', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16.0),
            Text('Next Watering Time: ${formatDuration(widget.plant.nextWateringTime.difference(DateTime.now()))}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                plantService.waterPlant(widget.plant.id);
                notificationService.scheduleNotification(widget.plant);
              },
              child: const Text('Mark as Watered'),
            ),
          ],
        ),
      ),
    );
  }
}
