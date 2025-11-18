```markdown
Panduan singkat konfigurasi Firebase (Android):
1. Buka https://console.firebase.google.com dan buat project baru.
2. Aktifkan Authentication -> Sign-in method -> Email/Password.
3. Tambahkan aplikasi Android menggunakan package name yang ada di android/app/src/main/AndroidManifest.xml.
4. Download google-services.json lalu letakkan di android/app/.
5. Tambahkan plugin Google Services pada android/build.gradle dan android/app/build.gradle sesuai dokumentasi Firebase Flutter.
6. Buat Firestore database (mode test untuk pengembangan).
7. Pastikan rules Firestore sederhananya:
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if request.auth != null;
       }
     }
   }
8. Jalankan: flutter pub get -> flutter run
Catatan: Untuk produksi, perketat rules Firestore dan amankan file konfigurasi.
```