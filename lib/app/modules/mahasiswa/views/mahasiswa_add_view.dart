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
  final TextEditingController _tugasController = TextEditingController();
  final TextEditingController _materiController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.docId != null) {
      _loadExistingData(widget.docId!); // Jika ada docId, berarti ini edit data
    }
  }

  Future<void> _loadExistingData(String docId) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection(widget.type)
          .doc(docId)
          .get();
      if (doc.exists) {
        setState(() {
          var data = doc.data()!;
          _mataKuliahController.text = data['mata_kuliah'] ?? '';
          _hariController.text = data['hari'] ?? '';
          _tugasController.text = data['tugas'] ?? '';
          _materiController.text = data['materi'] ?? '';
          _deadlineController.text = data['deadline'] ?? '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docId == null
            ? 'Tambah ${widget.type}'
            : 'Edit ${widget.type}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _mataKuliahController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Mata Kuliah',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.book),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _hariController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Hari',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _tugasController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Tugas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.assignment),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _materiController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Materi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.menu_book),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _deadlineController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Deadline',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                onPressed: () async {
                  if (_mataKuliahController.text.isNotEmpty &&
                      _hariController.text.isNotEmpty) {
                    await _addData(
                      widget.type,
                      _mataKuliahController.text,
                      _hariController.text,
                      _tugasController.text,
                      _materiController.text,
                      _deadlineController.text,
                    );
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
                child: Center(
                  child: Text(
                    widget.docId == null
                        ? 'Simpan ${widget.type}'
                        : 'Perbarui ${widget.type}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addData(String type, String mataKuliah, String hari,
      String tugas, String materi, String deadline) async {
    try {
      final collection = FirebaseFirestore.instance.collection(type);
      await collection.add({
        'mata_kuliah': mataKuliah,
        'hari': hari,
        'tugas': tugas.isNotEmpty ? tugas : '',
        'materi': materi.isNotEmpty ? materi : '',
        'deadline': deadline.isNotEmpty ? deadline : '',
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }
}
