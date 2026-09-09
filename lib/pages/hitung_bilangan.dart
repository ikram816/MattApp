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
      hasil = 'Digit ditemukan:\n${daftarDigit.join(' + ')}\n\nTotal: $total';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jumlah Total Digit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // HEADER BANNER (Diselaraskan dengan Data Kelompok & Perhitungan)
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
                    Icons.functions_rounded,
                    size: 65,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Hitung Per Digit',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Masukkan teks campuran huruf dan angka. Sistem akan menjumlahkan setiap digit angka yang ditemukan.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: angkaController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Masukkan Teks atau Angka',
                      hintText: 'Contoh: abc 123 x4y5',
                      prefixIcon: const Icon(
                        Icons.text_fields_rounded,
                        color: Color(0xFF455A64),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF455A64),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF455A64),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: hitungTotal,
                      child: const Text(
                        'HITUNG TOTAL DIGIT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),

                  // TAMPILAN HASIL
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263238),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}