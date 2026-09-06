import 'package:flutter/material.dart';

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {
  final angkaController = TextEditingController();

  String hasil = '';

  void hitungTotal() {
    String input = angkaController.text.trim();

    if (input.isEmpty) {
      setState(() {
        hasil = 'Masukkan angka terlebih dahulu!';
      });
      return;
    }

    List<String> daftarAngka = input.split(',');

    double total = 0;

    for (String angka in daftarAngka) {
      double? nilai = double.tryParse(angka.trim());

      if (nilai == null) {
        setState(() {
          hasil = 'Format angka tidak valid!';
        });
        return;
      }

      total += nilai;
    }

    setState(() {
      hasil = 'Jumlah Total: $total';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jumlah Total Angka'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.functions,
              size: 70,
            ),

            const SizedBox(height: 20),

            const Text(
              'Hitung Jumlah Total Angka',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Masukkan beberapa angka dan pisahkan dengan koma (,)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: angkaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Angka',
                hintText: 'Contoh: 10, 20, 30, 40',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: hitungTotal,

                child: const Text(
                  'HITUNG TOTAL',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              hasil,
              textAlign: TextAlign.center,
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