import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeadlineAddView extends StatefulWidget {
  final String? docId;

  DeadlineAddView({this.docId});

  @override
  _DeadlineAddViewState createState() => _DeadlineAddViewState();
}

class _DeadlineAddViewState extends State<DeadlineAddView> {
  final TextEditingController _namaDeadlineController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

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
          .collection('Deadline')
          .doc(docId)
          .get();
      if (doc.exists) {
        setState(() {
          var data = doc.data()!;
          _namaDeadlineController.text = data['nama_deadline'] ?? '';
          _tanggalController.text = data['tanggal'] ?? '';
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
        title: Text(widget.docId == null ? 'Tambah Deadline' : 'Edit Deadline'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _namaDeadlineController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Deadline',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.assignment),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _tanggalController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Tanggal',
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
                  if (_namaDeadlineController.text.isNotEmpty &&
                      _tanggalController.text.isNotEmpty) {
                    await _addData(
                      _namaDeadlineController.text,
                      _tanggalController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deadline berhasil ditambahkan')),
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
                        ? 'Simpan Deadline'
                        : 'Perbarui Deadline',
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

  Future<void> _addData(String namaDeadline, String tanggal) async {
    try {
      final collection = FirebaseFirestore.instance.collection('Deadline');
      await collection.add({
        'nama_deadline': namaDeadline,
        'tanggal': tanggal,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }
}
