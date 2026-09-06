import 'package:flutter/material.dart';
import 'tombol_angka.dart';

class PerhitunganPage extends StatefulWidget {
  const PerhitunganPage({super.key});

  @override
  State<PerhitunganPage> createState() => _PerhitunganPageState();
}

class _PerhitunganPageState extends State<PerhitunganPage> {
  final angka1Controller = TextEditingController();
  final angka2Controller = TextEditingController();

  String operasi = '';
  String hasil = '';

  TextEditingController? inputAktif;

  @override
  void dispose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.dispose();
  }

  // Memasukkan angka
  void masukkanAngka(String angka) {
    if (inputAktif == null) return;

    setState(() {
      inputAktif!.text += angka;

      inputAktif!.selection = TextSelection.fromPosition(
        TextPosition(
          offset: inputAktif!.text.length,
        ),
      );
    });
  }

  // Tombol titik
  void masukkanTitik() {
    if (inputAktif == null) return;

    // Supaya titik tidak bisa dimasukkan dua kali
    if (inputAktif!.text.contains('.')) return;

    setState(() {
      if (inputAktif!.text.isEmpty) {
        inputAktif!.text = '0.';
      } else {
        inputAktif!.text += '.';
      }
    });
  }

  // Tombol hapus
  void hapusAngka() {
    if (inputAktif == null) return;

    if (inputAktif!.text.isNotEmpty) {
      setState(() {
        inputAktif!.text = inputAktif!.text.substring(
          0,
          inputAktif!.text.length - 1,
        );
      });
    }
  }

  // Tombol C
  void clearAngka() {
    setState(() {
      angka1Controller.clear();
      angka2Controller.clear();
      operasi = '';
      hasil = '';
    });
  }

  // Pilih operasi
  void pilihOperasi(String op) {
    if (angka1Controller.text.isEmpty) {
      return;
    }

    setState(() {
      operasi = op;
      inputAktif = angka2Controller;
    });
  }

  // Tombol =
  void hitungHasil() {
    double? angka1 = double.tryParse(
      angka1Controller.text,
    );

    double? angka2 = double.tryParse(
      angka2Controller.text,
    );

    if (angka1 == null || angka2 == null) {
      setState(() {
        hasil = 'Masukkan kedua angka!';
      });
      return;
    }

    if (operasi.isEmpty) {
      setState(() {
        hasil = 'Pilih operasi terlebih dahulu!';
      });
      return;
    }

    double nilaiHasil = 0;

    switch (operasi) {
      case '+':
        nilaiHasil = angka1 + angka2;
        break;

      case '-':
        nilaiHasil = angka1 - angka2;
        break;

      case '×':
        nilaiHasil = angka1 * angka2;
        break;

      case '÷':
        if (angka2 == 0) {
          setState(() {
            hasil = 'Tidak bisa dibagi dengan 0!';
          });
          return;
        }

        nilaiHasil = angka1 / angka2;
        break;
    }

    setState(() {
      hasil = 'Hasil: $nilaiHasil';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perhitungan'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const Text(
              'Kalkulator',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Angka pertama
            TextField(
              controller: angka1Controller,
              readOnly: true,
              onTap: () {
                setState(() {
                  inputAktif = angka1Controller;
                });
              },
              decoration: InputDecoration(
                labelText: 'Angka Pertama',
                border: const OutlineInputBorder(),
                suffixIcon: Icon(
                  inputAktif == angka1Controller
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Operasi yang dipilih
            Text(
              operasi.isEmpty ? '?' : operasi,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Angka kedua
            TextField(
              controller: angka2Controller,
              readOnly: true,
              onTap: () {
                setState(() {
                  inputAktif = angka2Controller;
                });
              },
              decoration: InputDecoration(
                labelText: 'Angka Kedua',
                border: const OutlineInputBorder(),
                suffixIcon: Icon(
                  inputAktif == angka2Controller
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // OPERASI
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => pilihOperasi('+'),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => pilihOperasi('-'),
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => pilihOperasi('×'),
                    child: const Text(
                      '×',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => pilihOperasi('÷'),
                    child: const Text(
                      '÷',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // KEYPAD
            NumericKeypad(
              onNumberPressed: masukkanAngka,
              onDelete: hapusAngka,
              onClear: clearAngka,
              onDot: masukkanTitik,
              onEquals: hitungHasil,
            ),

            const SizedBox(height: 25),

            // HASIL
            Text(
              hasil,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}