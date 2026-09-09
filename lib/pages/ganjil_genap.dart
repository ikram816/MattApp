import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});

  @override
  State<GanjilGenapPage> createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final angkaController = TextEditingController();

  String hasil = '';

  @override
  void dispose() {
    angkaController.dispose();
    super.dispose();
  }

  void cekGanjilGenap() {
    String input = angkaController.text.trim();

    if (input.isEmpty) {
      setState(() {
        hasil = 'Masukkan angka terlebih dahulu!';
      });
      return;
    }

    // Menggunakan BigInt.tryParse agar mendukung angka yang sangat panjang (> 15 digit)
    BigInt? angka = BigInt.tryParse(input);

    if (angka == null) {
      setState(() {
        hasil = 'Format angka tidak valid!';
      });
      return;
    }

    if (angka % BigInt.from(2) == BigInt.zero) {
      setState(() {
        hasil = '$angka adalah bilangan GENAP';
      });
    } else {
      setState(() {
        hasil = '$angka adalah bilangan GANJIL';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ganjil / Genap',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // HEADER BANNER (Diselaraskan dengan halaman lainnya)
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
                    Icons.filter_list_rounded,
                    size: 65,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Cek Ganjil / Genap',
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
                    'Masukkan angka untuk mengecek apakah bilangan tersebut ganjil atau genap.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: angkaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Hanya menerima angka
                    ],
                    decoration: InputDecoration(
                      labelText: 'Masukkan Angka',
                      hintText: 'Contoh: 10',
                      prefixIcon: const Icon(
                        Icons.numbers_rounded,
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
                      onPressed: cekGanjilGenap,
                      child: const Text(
                        'CEK BILANGAN',
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