import 'package:flutter/material.dart';
import 'dart:async';
import '../models/plant_model.dart';
import '../screens/plant_detail_screen.dart';
import '../utils/utils.dart';

// In PlantCard
class PlantCard extends StatefulWidget {
  final Plant plant;
  final Function deletePlant;
  final Function waterPlant;

  PlantCard(
      {required this.plant,
      required this.deletePlant,
      required this.waterPlant});

  @override
  _PlantCardState createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        const Duration(minutes: 1), (Timer t) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final nextWateringTime = widget.plant.nextWateringTime;
    final needsWatering = now.compareTo(nextWateringTime) > 0;

    final remainingTime = nextWateringTime.difference(now);
    String timeString = needsWatering
        ? 'Overdue by ${formatDuration(remainingTime.abs())}'
        : 'Next watering in: ${formatDuration(remainingTime)}';

    return Card(
      child: ListTile(
        leading: Icon(
          widget.plant.icon,
          color: widget.plant.color,
          shadows: const <Shadow>[Shadow(color: Colors.black, blurRadius: 3)],
        ),
        title: Text(widget.plant.name),
        subtitle: Text(
          timeString,
          style: TextStyle(
            color: needsWatering ? Colors.red : null,
            fontWeight: needsWatering ? FontWeight.bold : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                widget.waterPlant(widget.plant.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.deletePlant(widget.plant.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Deleted ${widget.plant.name}'),
                      duration: const Duration(seconds: 1)),
                );
              },
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
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
