import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const PopUpChatApp());
}

class PopUpChatApp extends StatelessWidget {
  const PopUpChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LobbyScreen(),
    );
  }
}

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});

  void _bukaPopUpChat(BuildContext context, String namaRoom) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChatRoomPopUp(namaRoom: namaRoom),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumpul - Lobby Room'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.chat, color: Colors.white),
              ),
              title: const Text('Room Santai Malam'),
              subtitle: const Text('Ketuk untuk masuk ke dalam room'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _bukaPopUpChat(context, 'Room Santai Malam'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(Icons.workspace_premium, color: Colors.black),
              ),
              title: const Text('Room Sultan SVIP 1 - 7'),
              subtitle: const Text('Uji coba efek masuk SVIP 1 sampai 7'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _bukaPopUpChat(context, 'Room Sultan SVIP'),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatRoomPopUp extends StatefulWidget {
  final String namaRoom;
  const ChatRoomPopUp({super.key, required this.namaRoom});

  @override
  State<ChatRoomPopUp> createState() => _ChatRoomPopUpState();
}

class _ChatRoomPopUpState extends State<ChatRoomPopUp> {
  final TextEditingController _pesanController = TextEditingController();

  final List<Map<String, dynamic>> _daftarPesan = [
    {'pengirim': 'Admin', 'teks': 'Selamat datang di room!', 'svip': 0, 'isSistem': false},
  ];

  Map<String, dynamic>? _efekAktif;
  Timer? _timerEfek;

  // Level SVIP akun Anda saat ini (ubah angka 1 sampai 7 untuk mengganti level Anda)
  int _levelSvipSaya = 7;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pemainMasukRoom('Saya', _levelSvipSaya);
    });
  }

  @override
  void dispose() {
    _timerEfek?.cancel();
    _pesanController.dispose();
    super.dispose();
  }

  void _pemainMasukRoom(String namaPemain, int levelSvip) {
    setState(() {
      _daftarPesan.add({
        'pengirim': namaPemain,
        'teks': 'memasuki ruangan',
        'svip': levelSvip,
        'isSistem': true,
      });

      if (levelSvip > 0) {
        _efekAktif = {
          'nama': namaPemain,
          'svip': levelSvip,
        };
      }
    });

    if (levelSvip > 0) {
      _timerEfek?.cancel();
      _timerEfek = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _efekAktif = null;
          });
        }
      });
    }
  }

  void _kirimPesan() {
    final teks = _pesanController.text.trim();
    if (teks.isEmpty) return;

    setState(() {
      _daftarPesan.add({
        'pengirim': 'Saya',
        'teks': teks,
        'svip': _levelSvipSaya,
        'isSistem': false,
      });
    });
    _pesanController.clear();
  }

  // Konfigurasi Lengkap SVIP 1 sampai SVIP 7
  Map<String, dynamic> _getConfigSvip(int level) {
    switch (level) {
      case 1:
        return {
          'label': 'SVIP 1',
          'ikon': Icons.shield,
          'warna': [Colors.teal.shade700, Colors.teal.shade400],
          'badgeColor': Colors.teal,
          'teksWarna': Colors.white,
          'judul': 'Pendatang Baru VIP!',
        };
      case 2:
        return {
          'label': 'SVIP 2',
          'ikon': Icons.bolt,
          'warna': [Colors.blue.shade800, Colors.lightBlue.shade400],
          'badgeColor': Colors.blue,
          'teksWarna': Colors.white,
          'judul': 'Ksatria Biru tiba!',
        };
      case 3:
        return {
          'label': 'SVIP 3',
          'ikon': Icons.auto_awesome,
          'warna': [Colors.indigo.shade800, Colors.purpleAccent],
          'badgeColor': Colors.indigo,
          'teksWarna': Colors.white,
          'judul': 'Bangsawan Malam hadir!',
        };
      case 4:
        return {
          'label': 'SVIP 4',
          'ikon': Icons.local_fire_department,
          'warna': [Colors.purple.shade900, Colors.pinkAccent],
          'badgeColor': Colors.purple,
          'teksWarna': Colors.white,
          'judul': 'Aura Ungu menyala!',
        };
      case 5:
        return {
          'label': 'SVIP 5',
          'ikon': Icons.whatshot,
          'warna': [Colors.red.shade900, Colors.orange.shade600],
          'badgeColor': Colors.red,
          'teksWarna': Colors.white,
          'judul': 'Naga Merah memasuki room!',
        };
      case 6:
        return {
          'label': 'SVIP 6',
          'ikon': Icons.diamond,
          'warna': [Colors.amber.shade800, Colors.amber.shade400],
          'badgeColor': Colors.amber.shade700,
          'teksWarna': Colors.black,
          'judul': 'SULTAN EMAS TELAH TIBA!',
        };
      case 7:
      default:
        return {
          'label': 'SVIP 7',
          'ikon': Icons.workspace_premium,
          'warna': [const Color(0xFF1A1A2E), const Color(0xFFD4AF37), const Color(0xFF1A1A2E)],
          'badgeColor': const Color(0xFFD4AF37),
          'teksWarna': Colors.white,
          'judul': 'KAISAR TERTINGGI SVIP 7 HADIR!',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Header Room
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.namaRoom,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Bar Uji Coba SVIP 1 sampai SVIP 7 (Bisa digeser ke samping)
                Container(
                  color: Colors.deepPurple.shade50,
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text('Tes Masuk:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      _tombolTes('SVIP 1', Colors.teal, () => _pemainMasukRoom('Pemain_1', 1)),
                      _tombolTes('SVIP 2', Colors.blue, () => _pemainMasukRoom('Pemain_2', 2)),
                      _tombolTes('SVIP 3', Colors.indigo, () => _pemainMasukRoom('Pemain_3', 3)),
                      _tombolTes('SVIP 4', Colors.purple, () => _pemainMasukRoom('Pemain_4', 4)),
                      _tombolTes('SVIP 5', Colors.red, () => _pemainMasukRoom('Pemain_5', 5)),
                      _tombolTes('SVIP 6', Colors.amber.shade800, () => _pemainMasukRoom('Sultan_6', 6)),
                      _tombolTes('SVIP 7', Colors.black87, () => _pemainMasukRoom('Kaisar_7', 7)),
                    ],
                  ),
                ),

                // Daftar Pesan & Notifikasi Masuk
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _daftarPesan.length,
                    itemBuilder: (context, index) {
                      final pesan = _daftarPesan[index];
                      final int levelSvip = pesan['svip'] ?? 0;
                      final bool isSistem = pesan['isSistem'] ?? false;

                      if (isSistem) {
                        final config = levelSvip > 0 ? _getConfigSvip(levelSvip) : null;
                        return Center(

   
