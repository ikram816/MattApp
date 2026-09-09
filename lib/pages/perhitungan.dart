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
    inputAktif = angka1Controller;
  }

  @override
  void dispose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.dispose();
  }

  String _normalizeInput(String text) {
    return text.replaceAll(',', '.').trim();
  }

  void masukkanAngka(String angka) {
    if (inputAktif == null) return;

    setState(() {
      inputAktif!.text += angka;
      inputAktif!.selection = TextSelection.fromPosition(
        TextPosition(offset: inputAktif!.text.length),
      );
    });
  }

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

  void clearAngka() {
    setState(() {
      angka1Controller.clear();
      angka2Controller.clear();
      operasi = '';
      hasil = '';
      inputAktif = angka1Controller;
    });
  }

  void pilihOperasi(String op) {
    if (angka1Controller.text.isEmpty) return;

    setState(() {
      operasi = op;
      inputAktif = angka2Controller;
    });
  }

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
        title: const Text(
          'Perhitungan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // HEADER BANNER (Diselaraskan dengan Data Kelompok)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF455A64), // Dark Blue-Grey
                    Color(0xFF78909C), // Medium Blue-Grey
                  ],
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.calculate_rounded,
                    size: 65,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Kalkulator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // KARTU FORM INPUT
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
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
                      prefixIcon: const Icon(Icons.looks_one_outlined, color: Color(0xFF455A64)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF455A64), width: 2),
                      ),
                      suffixIcon: Icon(
                        inputAktif == angka1Controller
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: inputAktif == angka1Controller ? const Color(0xFF455A64) : Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Indicator Operasi
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEFF1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      operasi.isEmpty ? '?' : operasi,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF37474F),
                      ),
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
                      prefixIcon: const Icon(Icons.looks_two_outlined, color: Color(0xFF455A64)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF455A64), width: 2),
                      ),
                      suffixIcon: Icon(
                        inputAktif == angka2Controller
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: inputAktif == angka2Controller ? const Color(0xFF455A64) : Colors.grey,
                      ),
                    ),
                  ),

                  // HASIL OPERASI (Diletakkan di Bawah Angka Kedua)
                  if (hasil.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECEFF1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFCFD8DC)),
                      ),
                      child: Text(
                        hasil,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263238),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TOMBOL OPERASI (Grid 2x2)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.2,
              children: [
                _buildOperationButton('+'),
                _buildOperationButton('-'),
                _buildOperationButton('×'),
                _buildOperationButton('÷'),
              ],
            ),

            const SizedBox(height: 20),

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

  // Tombol Operasi bergaya Slate / Blue-Grey
  Widget _buildOperationButton(String symbol) {
    bool isSelected = operasi == symbol;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF455A64) : const Color(0xFFCFD8DC),
        foregroundColor: isSelected ? Colors.white : const Color(0xFF37474F),
        elevation: isSelected ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () => pilihOperasi(symbol),
      child: Text(
        symbol,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}