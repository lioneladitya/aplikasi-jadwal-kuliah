import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MahasiswaAddView extends StatefulWidget {
  final String type; // Menambahkan parameter untuk menentukan jenis data
  final String? docId; // Parameter untuk edit data (optional)

  MahasiswaAddView({required this.type, this.docId});

  @override
  _MahasiswaAddViewState createState() => _MahasiswaAddViewState();
}

class _MahasiswaAddViewState extends State<MahasiswaAddView> {
  final TextEditingController _mataKuliahController = TextEditingController();
  final TextEditingController _hariController = TextEditingController();
  final TextEditingController _tugasController = TextEditingController(); // Tugas
  final TextEditingController _materiController = TextEditingController(); // Materi
  final TextEditingController _deadlineController = TextEditingController(); // Deadline

  @override
  void initState() {
    super.initState();
    if (widget.docId != null) {
      _loadExistingData(widget.docId!); // Jika ada docId, berarti ini edit data
    }
  }

  Future<void> _loadExistingData(String docId) async {
    var doc = await FirebaseFirestore.instance.collection(widget.type).doc(docId).get();
    if (doc.exists) {
      var data = doc.data()!;
      _mataKuliahController.text = data['mata_kuliah'] ?? '';
      _hariController.text = data['hari'] ?? '';
      _tugasController.text = data['tugas'] ?? ''; // Menambah tugas
      _materiController.text = data['materi'] ?? ''; // Menambah materi
      _deadlineController.text = data['deadline'] ?? ''; // Menambah deadline
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docId == null ? 'Tambah ${widget.type}' : 'Edit ${widget.type}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field untuk nama mata kuliah
            TextField(
              controller: _mataKuliahController,
              decoration: InputDecoration(
                labelText: 'Masukkan Mata Kuliah',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Input field untuk hari
            TextField(
              controller: _hariController,
              decoration: InputDecoration(
                labelText: 'Masukkan Hari',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Kondisional untuk menambahkan input field berdasarkan jenis data
            if (widget.type == 'daftar_tugas' || widget.type == 'daftar_materi' || widget.type == 'daftar_deadline') ...[
              // Input field untuk tugas
              TextField(
                controller: _tugasController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Tugas',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
            ],
            if (widget.type == 'daftar_materi' || widget.type == 'daftar_deadline') ...[
              // Input field untuk materi
              TextField(
                controller: _materiController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Materi',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
            ],
            if (widget.type == 'daftar_deadline') ...[
              // Input field untuk deadline
              TextField(
                controller: _deadlineController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Deadline',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
            ],

            ElevatedButton(
              onPressed: () async {
                if (_mataKuliahController.text.isNotEmpty && _hariController.text.isNotEmpty) {
                  if (widget.type == 'daftar_tugas' && _tugasController.text.isNotEmpty) {
                    await _addData(
                        widget.type,
                        _mataKuliahController.text,
                        _hariController.text,
                        _tugasController.text,
                        '',
                        '');
                  } else if (widget.type == 'daftar_materi' && _materiController.text.isNotEmpty) {
                    await _addData(
                        widget.type,
                        _mataKuliahController.text,
                        _hariController.text,
                        '',
                        _materiController.text,
                        '');
                  } else if (widget.type == 'daftar_deadline' && _deadlineController.text.isNotEmpty) {
                    await _addData(
                        widget.type,
                        _mataKuliahController.text,
                        _hariController.text,
                        '',
                        '',
                        _deadlineController.text);
                  } else {
                    await _addData(
                        widget.type,
                        _mataKuliahController.text,
                        _hariController.text,
                        '',
                        '',
                        '');
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.type} berhasil ditambahkan')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Harap isi semua data')),
                  );
                }
              },
              child: Text(widget.docId == null ? 'Simpan ${widget.type}' : 'Perbarui ${widget.type}'),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menambahkan data ke Firestore
  Future<void> _addData(String type, String mataKuliah, String hari, String tugas, String materi, String deadline) async {
    final collection = FirebaseFirestore.instance.collection(type);
    await collection.add({
      'mata_kuliah': mataKuliah,
      'hari': hari,
      'tugas': tugas,
      'materi': materi,
      'deadline': deadline,
      'createdAt': Timestamp.now(),
    });
  }
}
