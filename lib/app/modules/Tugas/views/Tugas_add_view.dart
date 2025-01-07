import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TugasAddView extends StatefulWidget {
  final String? docId;

  TugasAddView({this.docId});

  @override
  _TugasAddViewState createState() => _TugasAddViewState();
}

class _TugasAddViewState extends State<TugasAddView> {
  final TextEditingController _namaTugasController = TextEditingController();
  final TextEditingController _matakuliahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.docId != null) {
      _loadExistingData(widget.docId!);
    }
  }

  Future<void> _loadExistingData(String docId) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection('Tugas')
          .doc(docId)
          .get();
      if (doc.exists) {
        setState(() {
          var data = doc.data()!;
          _namaTugasController.text = data['nama_tugas'] ?? '';
          _matakuliahController.text = data['matakuliah'] ?? '';
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
        title: Text(widget.docId == null ? 'Tambah Tugas' : 'Edit Tugas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _namaTugasController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Tugas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.assignment),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _matakuliahController,
                decoration: InputDecoration(
                  labelText: 'Masukkan matakuliah',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
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
                  if (_namaTugasController.text.isNotEmpty &&
                      _matakuliahController.text.isNotEmpty) {
                    await _addData(
                      _namaTugasController.text,
                      _matakuliahController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tugas berhasil ditambahkan')),
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
                        ? 'Simpan Tugas'
                        : 'Perbarui Tugas',
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
    Future<void> _addData(String namaTugas, String matakuliah) async {
    try {
      final collection = FirebaseFirestore.instance.collection('Tugas');
      await collection.add({
        'nama_tugas': namaTugas,
        'matakuliah': matakuliah,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }
}