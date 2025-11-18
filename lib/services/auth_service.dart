import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<UserModel?> get userStream => _auth.authStateChanges().asyncMap(_userFromFirebase);

  Future<UserModel?> _userFromFirebase(User? user) async {
    if (user == null) return null;
    final doc = await _db.collection('users').doc(user.uid).get();
    if (!doc.exists) return UserModel(uid: user.uid, email: user.email ?? '', role: 'siswa');
    return UserModel.fromMap(doc.data()!);
  }

  Future<String?> registerWithEmail({
    required String name,
    required String email,
    required String password,
    required String role, // 'guru' or 'siswa'
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = cred.user!.uid;
      final user = UserModel(uid: uid, name: name, email: email, role: role);
      await _db.collection('users').doc(uid).set(user.toMap());
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signInWithEmail({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}