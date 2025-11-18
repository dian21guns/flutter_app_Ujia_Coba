import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class DashboardTeacher extends StatelessWidget {
  final UserModel user;
  DashboardTeacher({required this.user});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Guru - ${user.name}')),
      body: Center(child: Text('Tempat mengelola bank soal dan ulangan')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () async => await auth.signOut(),
      ),
    );
  }
}