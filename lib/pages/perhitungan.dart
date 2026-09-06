import 'package:flutter/material.dart';

class PerhitunganPage extends StatefulWidget {
  const PerhitunganPage({super.key});

  @override
  State<PerhitunganPage> createState() => _PerhitunganPageState();
}

class _PerhitunganPageState extends State<PerhitunganPage> {
  final angka1Controller = TextEditingController();
  final angka2Controller = TextEditingController();

  String hasil = '';

  void hitung(String operasi) {
    double? angka1 = double.tryParse(angka1Controller.text);
    double? angka2 = double.tryParse(angka2Controller.text);

    if (angka1 == null || angka2 == null) {
      setState(() {
        hasil = 'Masukkan kedua angka terlebih dahulu!';
      });
      return;
    }

    double nilaiHasil = 0;

    if (operasi == '+') {
      nilaiHasil = angka1 + angka2;
    } else if (operasi == '-') {
      nilaiHasil = angka1 - angka2;
    } else if (operasi == '×') {
      nilaiHasil = angka1 * angka2;
    } else if (operasi == '÷') {
      if (angka2 == 0) {
        setState(() {
          hasil = 'Angka kedua tidak boleh 0!';
        });
        return;
      }

      nilaiHasil = angka1 / angka2;
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Masukkan Dua Angka',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: angka1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Pertama',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: angka2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Kedua',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('+'),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('-'),
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('×'),
                    child: const Text(
                      '×',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('÷'),
                    child: const Text(
                      '÷',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              hasil,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}