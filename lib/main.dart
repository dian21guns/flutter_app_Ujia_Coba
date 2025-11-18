import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_teacher.dart';
import 'screens/dashboard_student.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Aplikasi Ulangan',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: RootRouter(),
      ),
    );
  }
}

class RootRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return StreamBuilder<UserModel?>(
      stream: auth.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final user = snapshot.data;
        if (user == null) return LoginScreen();
        if (user.role == 'guru') return DashboardTeacher(user: user);
        return DashboardStudent(user: user);
      },
    );
  }
}