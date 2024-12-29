import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class HealthWorkerDashboard extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String generateTempPassword() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(8, (_) => characters.codeUnitAt(random.nextInt(characters.length))),
    );
  }

  Future<void> addParent(BuildContext context) async {
    String tempPassword = generateTempPassword();

    await firestore.collection('users').add({
      'name': nameController.text,
      'phone': phoneController.text,
      'role': 'parent',
      'temp_password': tempPassword,
      'added_by': 'healthWorkerId', // Replace with the health worker's ID
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Parent added with temp password: $tempPassword"),
      ),
    );

    nameController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Health Worker Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Parent Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => addParent(context),
              child: Text('Add Parent'),
            ),
          ],
        ),
      ),
    );
  }
}
