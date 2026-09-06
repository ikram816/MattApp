import 'package:flutter/material.dart';
import 'perhitungan.dart';
import 'ganjil_genap.dart';
import 'hitung_bilangan.dart'; 
import 'data_kelompok.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: const Text('Menu Utama'),
  centerTitle: true,
  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Keluar',
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
      },
    ),
  ],
),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Silakan pilih fitur yang ingin digunakan',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [
                  // DATA KELOMPOK
                  MenuCard(
  icon: Icons.groups,
  title: 'Data Kelompok',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DataKelompokPage(),
      ),
    );
  },
),

                  // PERHITUNGAN
                  MenuCard(
                    icon: Icons.calculate,
                    title: 'Perhitungan',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PerhitunganPage(),
                        ),
                      );
                    },
                  ),

                  // GANJIL / GENAP
                  MenuCard(
  icon: Icons.numbers,
  title: 'Ganjil / Genap',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GanjilGenapPage(),
      ),
    );
  },
),

                  // JUMLAH TOTAL ANGKA
                 MenuCard(
  icon: Icons.functions,
  title: 'Jumlah Total Angka',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const JumlahTotalPage(),
      ),
    );
  },
),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ==================================================
// WIDGET MENU CARD
// ==================================================

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),

        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 55,
              ),

              const SizedBox(height: 15),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}