import 'package:flutter/material.dart';

class SelectCategoryView extends StatelessWidget {
  const SelectCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"icon": Icons.local_dining, "label": "Food"},
      {"icon": Icons.shopping_bag, "label": "Shopping"},
      {"icon": Icons.directions_car, "label": "Transport"},
      {"icon": Icons.movie, "label": "Entertainment"},
      {"icon": Icons.fitness_center, "label": "Fitness"},
      {"icon": Icons.pets, "label": "Pets"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: categories.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, item["label"]);
              },
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Icon(item["icon"], size: 40, color: Colors.green.shade700),
                    const SizedBox(height: 10),
                    Text(item["label"]),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
