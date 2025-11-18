class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role; // 'guru' or 'siswa'

  UserModel({
    required this.uid,
    this.name = '',
    required this.email,
    this.role = 'siswa',
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'email': email,
        'role': role,
      };

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
        uid: m['uid'] ?? '',
        name: m['name'] ?? '',
        email: m['email'] ?? '',
        role: m['role'] ?? 'siswa',
      );
}