import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final String time;

  const ServiceCard({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.calendar_month, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Text(time, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
