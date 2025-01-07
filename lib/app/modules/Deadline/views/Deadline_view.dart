import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/app/modules/Deadline/views/Deadline_add_view.dart';


class DeadlineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Deadline'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Deadline').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada data Deadline.'));
          }

          var documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var doc = documents[index];
              var data = doc.data() as Map<String, dynamic>;

              var namaDeadline = data['nama_deadline'] ?? 'Tidak ada nama';
              var tanggal = data['tanggal'] ?? 'Tidak ada tanggal';

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('$namaDeadline - $tanggal'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeadlineAddView(
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
                          title: Text('Hapus Deadline'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus $namaDeadline?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                                FirebaseFirestore.instance
                                    .collection('Deadline')
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
                          SnackBar(content: Text('Deadline berhasil dihapus')),
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
              builder: (context) => DeadlineAddView(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah Deadline',
      ),
    );
  }
}
