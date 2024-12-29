import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shecha_immunize/admin_dashboard.dart';
import 'package:shecha_immunize/health_worker_dashboard.dart';
import 'package:shecha_immunize/login_screen.dart';
import 'package:shecha_immunize/parent_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login System',
      home: LoginScreen(),
      routes: {
  '/admin_dashboard': (context) => AdminDashboard(),
  '/health_worker_dashboard': (context) => HealthWorkerDashboard(),
  '/parent_dashboard': (context) => ParentDashboard(parentId: 'abc123',),
},

    );
    
  }
}
