import 'package:flutter/material.dart';

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {
  final angkaController = TextEditingController();

  String hasil = '';

  @override
  void dispose() {
    angkaController.dispose();
    super.dispose();
  }

  void hitungTotal() {
    String input = angkaController.text.trim();

    if (input.isEmpty) {
      setState(() {
        hasil = 'Masukkan teks atau angka terlebih dahulu!';
      });
      return;
    }

    // Mengambil semua karakter digit (0-9) dari teks input
    Iterable<Match> matches = RegExp(r'\d').allMatches(input);

    if (matches.isEmpty) {
      setState(() {
        hasil = 'Tidak ditemukan angka dalam input!';
      });
      return;
    }

    BigInt total = BigInt.zero;
    List<String> daftarDigit = [];

    // Menjumlahkan setiap digit angka satu per satu
    for (Match match in matches) {
      String digitStr = match.group(0)!;
      daftarDigit.add(digitStr);
      total += BigInt.parse(digitStr);
    }

    setState(() {
      // Menampilkan rincian digit yang dijumlahkan beserta totalnya
      hasil = 'Digit ditemukan: ${daftarDigit.join(' + ')}\nTotal: $total';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jumlah Total Digit'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
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
              'Hitung Jumlah Per Digit Angka',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: angkaController,
              keyboardType: TextInputType.text, // Menerima teks dan angka dari keyboard
              decoration: const InputDecoration(
                labelText: 'Masukkan Teks atau Angka',
                hintText: 'Contoh: abc 123 x4y5',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: hitungTotal,

                child: const Text(
                  'HITUNG TOTAL DIGIT',
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}