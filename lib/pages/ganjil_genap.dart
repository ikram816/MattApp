import 'package:flutter/material.dart';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});

  @override
  State<GanjilGenapPage> createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final angkaController = TextEditingController();

  String hasil = '';

  void cekGanjilGenap() {
    int? angka = int.tryParse(angkaController.text);

    if (angka == null) {
      setState(() {
        hasil = 'Masukkan angka terlebih dahulu!';
      });
      return;
    }

    if (angka % 2 == 0) {
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
        title: const Text('Ganjil / Genap'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.numbers,
              size: 70,
            ),

            const SizedBox(height: 20),

            const Text(
              'Cek Bilangan Ganjil atau Genap',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: angkaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Angka',
                hintText: 'Contoh: 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: cekGanjilGenap,

                child: const Text(
                  'CEK',
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