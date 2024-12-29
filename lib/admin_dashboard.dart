import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class AdminDashboard extends StatelessWidget {
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

  Future<void> addHealthWorker() async {
    String tempPassword = generateTempPassword();

    await firestore.collection('users').add({
      'name': nameController.text,
      'phone': phoneController.text,
      'role': 'health_worker',
      'temp_password': tempPassword,
      'added_by': 'adminId', // Replace with the admin's ID
    });

    print("Health worker added with temp password: $tempPassword");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Health Worker Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addHealthWorker,
              child: Text('Add Health Worker'),
            ),
          ],
        ),
      ),
    );
  }
}
