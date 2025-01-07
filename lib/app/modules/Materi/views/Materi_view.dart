import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/app/modules/Materi/views/Materi_add_view.dart';

class MateriView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Materi'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('materi').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada data materi.'));
          }

          var documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var doc = documents[index];
              var data = doc.data() as Map<String, dynamic>;

              var namaMateri = data['isi_materi'] ?? 'Tidak ada nama materi';
              var matakuliah = data['matakuliah'] ?? 'Tidak ada matakuliah';

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('$namaMateri - $matakuliah'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MateriAddView(
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
                          title: Text('Hapus materi'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus $namaMateri?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                                FirebaseFirestore.instance
                                    .collection('materi')
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
                          SnackBar(content: Text('materi berhasil dihapus')),
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
              builder: (context) => MateriAddView(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah materi',
      ),
    );
  }
}
