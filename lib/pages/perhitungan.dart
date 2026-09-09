import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();
    // Default fokus ke angka pertama saat pertama kali dibuka
    inputAktif = angka1Controller;
  }

  @override
  void dispose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.dispose();
  }

  // Sanitasi teks (mengubah koma menjadi titik)
  String _normalizeInput(String text) {
    return text.replaceAll(',', '.').trim();
  }

  // Memasukkan angka via Keypad
  void masukkanAngka(String angka) {
    if (inputAktif == null) return;

    setState(() {
      inputAktif!.text += angka;
      inputAktif!.selection = TextSelection.fromPosition(
        TextPosition(offset: inputAktif!.text.length),
      );
    });
  }

  // Tombol titik / koma via Keypad
  void masukkanTitik() {
    if (inputAktif == null) return;

    if (inputAktif!.text.contains('.') || inputAktif!.text.contains(',')) return;

    setState(() {
      if (inputAktif!.text.isEmpty) {
        inputAktif!.text = '0.';
      } else {
        inputAktif!.text += '.';
      }
      inputAktif!.selection = TextSelection.fromPosition(
        TextPosition(offset: inputAktif!.text.length),
      );
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
        inputAktif!.selection = TextSelection.fromPosition(
          TextPosition(offset: inputAktif!.text.length),
        );
      });
    }
  }

  // Tombol Clear (C)
  void clearAngka() {
    setState(() {
      angka1Controller.clear();
      angka2Controller.clear();
      operasi = '';
      hasil = '';
      inputAktif = angka1Controller;
    });
  }

  // Pilih operasi
  void pilihOperasi(String op) {
    if (angka1Controller.text.isEmpty) return;

    setState(() {
      operasi = op;
      inputAktif = angka2Controller;
    });
  }

  // Menghitung hasil dengan dukungan BigInt (presisi panjang) dan Double
  void hitungHasil() {
    String str1 = _normalizeInput(angka1Controller.text);
    String str2 = _normalizeInput(angka2Controller.text);

    if (str1.isEmpty || str2.isEmpty) {
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

    bool isDouble = str1.contains('.') || str2.contains('.');

    try {
      if (!isDouble) {
        // Menggunakan BigInt agar mendukung angka > 15 digit tanpa batas
        BigInt n1 = BigInt.parse(str1);
        BigInt n2 = BigInt.parse(str2);
        BigInt res = BigInt.zero;

        switch (operasi) {
          case '+':
            res = n1 + n2;
            break;
          case '-':
            res = n1 - n2;
            break;
          case '×':
            res = n1 * n2;
            break;
          case '÷':
            if (n2 == BigInt.zero) {
              setState(() => hasil = 'Tidak bisa dibagi dengan 0!');
              return;
            }
            // Jika pembagian tidak habis, ubah ke double
            if (n1 % n2 != BigInt.zero) {
              double resDouble = n1.toDouble() / n2.toDouble();
              setState(() => hasil = 'Hasil: $resDouble');
              return;
            } else {
              res = n1 ~/ n2;
            }
            break;
        }
        setState(() => hasil = 'Hasil: $res');
      } else {
        // Menggunakan Double untuk angka desimal
        double n1 = double.parse(str1);
        double n2 = double.parse(str2);
        double res = 0;

        switch (operasi) {
          case '+':
            res = n1 + n2;
            break;
          case '-':
            res = n1 - n2;
            break;
          case '×':
            res = n1 * n2;
            break;
          case '÷':
            if (n2 == 0) {
              setState(() => hasil = 'Tidak bisa dibagi dengan 0!');
              return;
            }
            res = n1 / n2;
            break;
        }
        setState(() => hasil = 'Hasil: $res');
      }
    } catch (e) {
      setState(() {
        hasil = 'Format angka tidak valid!';
      });
    }
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

            // Angka Pertama
            TextField(
              controller: angka1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              onTap: () {
                setState(() {
                  inputAktif = angka1Controller;
                });
              },
              onChanged: (_) => setState(() {}),
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

            // Indicator Operasi
            Text(
              operasi.isEmpty ? '?' : operasi,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Angka Kedua
            TextField(
              controller: angka2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              onTap: () {
                setState(() {
                  inputAktif = angka2Controller;
                });
              },
              onChanged: (_) => setState(() {}),
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

            // HASIL OPERASI
            if (hasil.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  hasil,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // TOMBOL OPERASI grid 2x2
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.2,
              children: [
                _buildOperationButton('+'),
                _buildOperationButton('-'),
                _buildOperationButton('×'),
                _buildOperationButton('÷'),
              ],
            ),

            const SizedBox(height: 10),

            // KEYPAD
            NumericKeypad(
              onNumberPressed: masukkanAngka,
              onDelete: hapusAngka,
              onClear: clearAngka,
              onDot: masukkanTitik,
              onEquals: hitungHasil,
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Membuat Tombol Operasi Besar
  Widget _buildOperationButton(String symbol) {
    bool isSelected = operasi == symbol;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFF78909C) : null,
        foregroundColor: isSelected ? Colors.white : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => pilihOperasi(symbol),
      child: Text(
        symbol,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}