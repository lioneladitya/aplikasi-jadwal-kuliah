import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'mahasiswa_add_view.dart'; // Import halaman untuk menambah dan mengedit data

class MahasiswaView extends StatelessWidget {
  final String type;

  MahasiswaView({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar $type'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(type).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada data $type.'));
          }

          var documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var doc = documents[index];
              var data = doc.data() as Map<String, dynamic>;

              // Validasi keberadaan field sebelum mengaksesnya
              var mataKuliah = data['mata_kuliah'] ?? 'Tidak ada mata kuliah';
              var hari = data['hari'] ?? 'Tidak ada hari';
              var tugas = data['tugas'] ?? 'Tidak ada tugas';
              var materi = data['materi'] ?? 'Tidak ada materi';
              var deadline = data['deadline'] ?? 'Tidak ada deadline';

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('$mataKuliah - $hari'),
                  subtitle: Text(
                    'Tugas: $tugas\nMateri: $materi\nDeadline: $deadline',
                  ),
                  onTap: () {
                    // Navigasi ke halaman edit
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MahasiswaAddView(
                          type: type,
                          docId: doc.id,
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      // Konfirmasi penghapusan data
                      bool? confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Hapus $type'),
                          content: Text('Apakah Anda yakin ingin menghapus $mataKuliah?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                                // Menghapus data dari Firestore
                                FirebaseFirestore.instance
                                    .collection(type)
                                    .doc(doc.id)
                                    .delete();
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        ),
                      );

                      // Jika user mengonfirmasi, maka hapus data
                      if (confirm == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$type berhasil dihapus')),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman tambah data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MahasiswaAddView(
                type: type,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah $type',
      ),
    );
  }
}
