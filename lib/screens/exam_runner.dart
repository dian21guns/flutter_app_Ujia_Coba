import 'dart:async';
import 'package:flutter/material.dart';

class ExamRunner extends StatefulWidget {
  @override
  _ExamRunnerState createState() => _ExamRunnerState();
}

class _ExamRunnerState extends State<ExamRunner> {
  int remainingSeconds = 60 * 20; // contoh 20 menit
  Timer? timer;
  int currentIndex = 0;
  Map<int, String> answers = {};

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (remainingSeconds > 0) remainingSeconds--;
        else {
          timer?.cancel();
          _submit();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _submit() {
    // TODO: simpan attempt ke Firestore + scoring
    showDialog(context: context, builder: (_) => AlertDialog(title: Text('Waktu Habis / Submit'), content: Text('Jawaban dikirim (contoh).')));
  }

  @override
  Widget build(BuildContext context) {
    final mm = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final ss = (remainingSeconds % 60).toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(title: Text('Ulangan - Waktu sisa $mm:$ss')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Soal contoh #${currentIndex + 1}'),
            SizedBox(height: 12),
            Text('Pilihan A / B / C / D (UI contoh)'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Next'),
              onPressed: () => setState(() => currentIndex++),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}