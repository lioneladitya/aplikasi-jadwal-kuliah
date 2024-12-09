import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MahasiswaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('mata_kuliah').snapshots(),
      builder: (context, snapshot) {
        // Menunggu data yang sedang dimuat
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Menampilkan error jika ada
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data?.docs ?? [];

        // Menampilkan data dalam bentuk ListView
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                data[index]['mata_kuliah'],
                style: TextStyle(fontSize: 16), // Ukuran font untuk mata kuliah
              ),
              subtitle: Text(
                data[index]['hari'],
                style: TextStyle(
                  fontSize: 20, // Ukuran font untuk hari lebih besar
                  color: Colors.yellow, // Warna kuning untuk hari
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  // Tampilkan dialog konfirmasi hapus
                  bool confirmDelete = await _confirmDelete(context);
                  if (confirmDelete) {
                    // Proses penghapusan data dari Firestore
                    await _deleteData(data[index].id, context);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Konfirmasi Hapus'),
            content: Text('Apakah Anda yakin ingin menghapus data ini?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // Mengembalikan false jika batal
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(true); // Mengembalikan true jika hapus
                },
                child: Text('Hapus'),
              ),
            ],
          ),
        ) ??
        false; // Jika dialog dibatalkan, return false
  }

  // Fungsi untuk menghapus data dari Firestore
  Future<void> _deleteData(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('mata_kuliah')
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus data')),
      );
    }
  }
}
