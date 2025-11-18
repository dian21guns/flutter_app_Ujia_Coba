import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'exam_runner.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class DashboardStudent extends StatelessWidget {
  final UserModel user;
  DashboardStudent({required this.user});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Siswa - ${user.name}')),
      body: Center(
        child: ElevatedButton(
          child: Text('Mulai Contoh Ulangan'),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExamRunner())),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () async => await auth.signOut(),
      ),
    );
  }
}