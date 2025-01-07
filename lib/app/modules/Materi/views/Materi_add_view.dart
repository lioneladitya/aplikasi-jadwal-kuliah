import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MateriAddView extends StatefulWidget {
  final String? docId;

  MateriAddView({this.docId});

  @override
  _MateriAddViewState createState() => _MateriAddViewState();
}

class _MateriAddViewState extends State<MateriAddView> {
  final TextEditingController _materiController = TextEditingController();
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
          .collection('materi')
          .doc(docId)
          .get();
      if (doc.exists) {
        setState(() {
          var data = doc.data()!;
          _materiController.text = data['isi_materi'] ?? '';
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
        title: Text(widget.docId == null ? 'Tambah Isi Materi' : 'Edit Materi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _materiController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Isi Materi',
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
                  if (_materiController.text.isNotEmpty &&
                      _matakuliahController.text.isNotEmpty) {
                    await _addData(
                      _materiController.text,
                      _matakuliahController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Materi berhasil ditambahkan')),
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
                    widget.docId == null ? 'Simpan Materi' : 'Perbarui Materi',
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

  Future<void> _addData(String materi, String matakuliah) async {
    try {
      final collection = FirebaseFirestore.instance.collection('materi');
      await collection.add({
        'Materi': materi,
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
