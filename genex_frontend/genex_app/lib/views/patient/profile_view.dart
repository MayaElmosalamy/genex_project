//Patient Profile screen with editable fields (name, weight, etc.)

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  int age = 0;
  String gender = '';
  double weight = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Patient Information",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: "Name"),
              onChanged: (v) => setState(() => name = v),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => age = int.tryParse(v) ?? 0),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Gender"),
              onChanged: (v) => setState(() => gender = v),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => weight = double.tryParse(v) ?? 0),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Height (cm)"),
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => height = double.tryParse(v) ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}
