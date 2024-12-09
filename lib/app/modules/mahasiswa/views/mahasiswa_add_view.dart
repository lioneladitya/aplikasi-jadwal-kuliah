import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MahasiswaAddView extends StatefulWidget {
  @override
  _MahasiswaAddViewState createState() => _MahasiswaAddViewState();
}

class _MahasiswaAddViewState extends State<MahasiswaAddView> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _mataKuliahControllers =
      List.generate(5, (_) => TextEditingController());
  final TextEditingController _hariController = TextEditingController();

  // Fungsi untuk menambah mata kuliah dan hari ke Firebase
  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Proses pengiriman data untuk setiap mata kuliah
        for (int i = 0; i < 5; i++) {
          if (_mataKuliahControllers[i].text.isNotEmpty) {
            await FirebaseFirestore.instance.collection('mata_kuliah').add({
              'mata_kuliah': _mataKuliahControllers[i].text,
              'hari': _hariController
                  .text, // Menambahkan hari untuk setiap mata kuliah
              'created_at': FieldValue.serverTimestamp(),
            });
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil ditambahkan')),
        );
        Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Mata Kuliah dan Hari'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: _submitData,
              icon: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Tambahkan Data'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Input untuk Hari
              TextFormField(
                controller: _hariController,
                decoration: InputDecoration(
                  labelText: 'Hari (diisi satu kali untuk semua)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hari harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // List Mata Kuliah dan Input untuk setiap Mata Kuliah
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // Menyesuaikan dengan ukuran konten
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _mataKuliahControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Mata Kuliah ${index + 1}',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama mata kuliah bisa kosong, tetapi jika diisi harus valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitData,
        child: Icon(Icons.save),
        tooltip: 'Simpan Data',
      ),
    );
  }
}
