import 'package:flutter/material.dart';
import 'dart:async';
import '../models/plant_model.dart';
import '../screens/plant_detail_screen.dart';
import '../utils/utils.dart';

// In PlantCard
class PlantCard extends StatefulWidget {
  final Plant plant;

  PlantCard({required this.plant});

  @override
  _PlantCardState createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
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
    return Card(
      child: ListTile(
        title: Text(widget.plant.name),
        subtitle: Text(
            'Next watering in: ${formatDuration(widget.plant.nextWateringTime.difference(DateTime.now()))}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlantDetailScreen(plant: widget.plant)),
          );
        },
      ),
    );
  }
}

// Similar changes for PlantDetailScreen
