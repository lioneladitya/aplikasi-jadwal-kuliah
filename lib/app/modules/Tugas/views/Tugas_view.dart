import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/app/modules/Tugas/views/Tugas_add_view.dart';

class TugasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Tugas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada data Tugas.'));
          }

          var documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var doc = documents[index];
              var data = doc.data() as Map<String, dynamic>;

              var namaTugas = data['nama_tugas'] ?? 'Tidak ada nama tugas';
              var matakuliah = data['matakuliah'] ?? 'Tidak ada matakuliah';

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('$namaTugas - $matakuliah'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TugasAddView(
                          docId: doc.id,
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      bool? confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Hapus Tugas'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus $namaTugas?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                                FirebaseFirestore.instance
                                    .collection('Tugas')
                                    .doc(doc.id)
                                    .delete();
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tugas berhasil dihapus')),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TugasAddView(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah Tugas',
      ),
    );
  }
}
