import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRegister = false;
  String role = 'siswa';
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Aplikasi Ulangan')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SwitchListTile(
                title: Text(isRegister ? 'Mode Register' : 'Mode Login'),
                value: isRegister,
                onChanged: (v) => setState(() => isRegister = v),
              ),
              if (isRegister)
                TextFormField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Nama'), validator: (v) => v!.isEmpty ? 'Nama wajib' : null),
              TextFormField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email'), validator: (v) => v!.contains('@') ? null : 'Email tidak valid'),
              TextFormField(controller: _passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true, validator: (v) => v!.length >= 6 ? null : 'Minimal 6 karakter'),
              if (isRegister)
                DropdownButtonFormField<String>(
                  value: role,
                  items: [
                    DropdownMenuItem(value: 'siswa', child: Text('Siswa')),
                    DropdownMenuItem(value: 'guru', child: Text('Guru')),
                  ],
                  onChanged: (v) => setState(() => role = v!),
                  decoration: InputDecoration(labelText: 'Peran'),
                ),
              SizedBox(height: 12),
              ElevatedButton(
                child: Text(isRegister ? 'Daftar' : 'Login'),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  setState(() => _error = null);
                  if (isRegister) {
                    final err = await auth.registerWithEmail(
                      name: _nameCtrl.text.trim(),
                      email: _emailCtrl.text.trim(),
                      password: _passCtrl.text.trim(),
                      role: role,
                    );
                    if (err != null) setState(() => _error = err);
                  } else {
                    final err = await auth.signInWithEmail(email: _emailCtrl.text.trim(), password: _passCtrl.text.trim());
                    if (err != null) setState(() => _error = err);
                  }
                },
              ),
              if (_error != null) Text(_error!, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}