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
        title: const Text('Hesa Chat Lobby'),
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
                child: Icon(Icons.forum, color: Colors.white),
              ),
              title: const Text('Room Ngobrol Santai'),
              subtitle: const Text('Ketuk Masuk untuk buka pop-up chat'),
              trailing: ElevatedButton(
                onPressed: () => _bukaPopUpChat(context, 'Room Ngobrol Santai'),
                child: const Text('Masuk'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.mic, color: Colors.white),
              ),
              title: const Text('Room Mabar & Voice'),
              subtitle: const Text('Ketuk Masuk untuk buka pop-up chat'),
              trailing: ElevatedButton(
                onPressed: () => _bukaPopUpChat(context, 'Room Mabar & Voice'),
                child: const Text('Masuk'),
              ),
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
  final List<Map<String, String>> _daftarPesan = [
    {'pengirim': 'Sistem', 'teks': 'Selamat datang di ruang obrolan!'},
  ];

  void _kirimPesan() {
    if (_pesanController.text.trim().isEmpty) return;
    setState(() {
      _daftarPesan.add({
        'pengirim': 'Saya',
        'teks': _pesanController.text.trim(),
      });
    });
    _pesanController.clear();
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
        child: Column(
          children: [
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _daftarPesan.length,
                itemBuilder: (context, index) {
                  final pesan = _daftarPesan[index];
                  final isSaya = pesan['pengirim'] == 'Saya';
                  return Align(
                    alignment: isSaya ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSaya ? Colors.deepPurple : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pesan['pengirim']!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSaya ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            pesan['teks']!,
                            style: TextStyle(
                              color: isSaya ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _pesanController,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _kirimPesan,
                    ),
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
