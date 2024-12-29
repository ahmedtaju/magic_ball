import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentDashboard extends StatelessWidget {
  final String parentId;

  ParentDashboard({required this.parentId});

  Future<Map<String, dynamic>> getParentData() async {
    DocumentSnapshot parentDoc =
        await FirebaseFirestore.instance.collection('users').doc(parentId).get();

    return parentDoc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parent Dashboard")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getParentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No data found"));
          }

          Map<String, dynamic> parentData = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: ${parentData['name']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Phone: ${parentData['phone']}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Upcoming Appointments:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Placeholder for appointments
                Text("No appointments scheduled yet."),
              ],
            ),
          );
        },
      ),
    );
  }
}
