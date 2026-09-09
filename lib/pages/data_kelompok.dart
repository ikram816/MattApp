import 'package:flutter/material.dart';

class DataKelompokPage extends StatelessWidget {
  const DataKelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Kelompok',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF455A64), // Dark Blue-Grey / Abu-abu gelap netral
                    Color(0xFF78909C), // Medium Blue-Grey
                  ],
                ),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.groups_rounded,
                    size: 65,
                    color: Colors.white,
                  ),

                  SizedBox(height: 15),

                  Text(
                    'MathApp Kelompok',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  SizedBox(height: 8),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // JUDUL
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Anggota Kelompok',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ANGGOTA 1
            const MemberCard(
              nomor: '01',
              inisial: 'MB',
              nama: 'Muhammad Barkah Ramadhan',
              nim: '124240004',
            ),

            const SizedBox(height: 15),

            // ANGGOTA 2
            const MemberCard(
              nomor: '02',
              inisial: 'IPS',
              nama: 'Ikram Paishal Shidiq',
              nim: '124240036',
            ),

            const SizedBox(height: 15),

            // ANGGOTA 3
            const MemberCard(
              nomor: '03',
              inisial: 'MA',
              nama: 'Muhammad Aqillius Abidza HR',
              nim: '124240127',
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}


// ==================================================
// MEMBER CARD
// ==================================================

class MemberCard extends StatelessWidget {
  final String nomor;
  final String inisial;
  final String nama;
  final String nim;

  const MemberCard({
    super.key,
    required this.nomor,
    required this.inisial,
    required this.nama,
    required this.nim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            // Mengganti withOpacity dengan withValues agar tidak warning
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // AVATAR
          Container(
            width: 60,
            height: 60,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF546E7A), // Abu-abu netral sedang
                  Color(0xFF90A4AE), // Abu-abu netral terang
                ],
              ),
            ),

            child: Center(
              child: Text(
                inisial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // DATA ANGGOTA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ANGGOTA $nomor',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.badge_outlined,
                      size: 16,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      nim,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}