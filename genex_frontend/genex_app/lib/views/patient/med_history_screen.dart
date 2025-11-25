//Medicine History screen where patients add and view their medications

import 'package:flutter/material.dart';

class MedHistoryScreen extends StatefulWidget {
  const MedHistoryScreen({super.key});

  @override
  State<MedHistoryScreen> createState() => _MedHistoryScreenState();
}

class _MedHistoryScreenState extends State<MedHistoryScreen> {
  final List<String> medicines = [];
  String? selectedMed;

  final List<String> medicineOptions = const [
    "Vitamin D",
    "Metformin",
    "Prednisone",
    "Thyroxine",
    "Ibuprofen",
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addMedicine(String med) {
    medicines.add(med);
    _listKey.currentState?.insertItem(medicines.length - 1);
  }

  void _removeMedicine(int index) {
    final removed = medicines.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text(removed)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine History')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add a Medicine",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedMed,
                    hint: const Text("Select Medicine"),
                    items: medicineOptions
                        .map((med) => DropdownMenuItem(value: med, child: Text(med)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedMed = value),
                  ),
                ),
                ElevatedButton(
                  onPressed: selectedMed == null
                      ? null
                      : () {
                          if (!medicines.contains(selectedMed)) {
                            _addMedicine(selectedMed!);
                          }
                        },
                  child: const Text("Add"),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text("Patient Medicines:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: medicines.length,
                itemBuilder: (context, index, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      title: Text(medicines[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _removeMedicine(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
