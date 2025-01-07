import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/Tugas/views/Tugas_add_view.dart';
import '../controllers/home_controller.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_add_view.dart';
import 'package:myapp/app/modules/Materi/views/Materi_add_view.dart';
import 'package:myapp/app/modules/Deadline/views/Deadline_add_view.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_view.dart';
import 'package:myapp/app/modules/Materi/views/Materi_view.dart';
import 'package:myapp/app/modules/Tugas/views/Tugas_view.dart';
import 'package:myapp/app/modules/Deadline/views/Deadline_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardAdmin();
  }
}

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final List<Map<String, dynamic>> _fragment = [
    {
      'title': 'Mata Kuliah',
      'view': (BuildContext context) => MahasiswaView(type: 'mata_kuliah'),
      'add': (BuildContext context) => MahasiswaAddView(type: 'mata_kuliah'),
      'icon': Icons.school,
    },
    {
      'title': 'Daftar Tugas',
      'view': (BuildContext context) => TugasView(),
      'add': (BuildContext context) => TugasAddView(),
      'icon': Icons.task,
    },
    {
      'title': 'Pencatatan Materi',
      'view': (BuildContext context) => MateriView(),
      'add': (BuildContext context) => MateriAddView(),
      'icon': Icons.note_alt,
    },
    {
      'title': 'Daftar Deadline',
      'view': (BuildContext context) => DeadlineView(),
      'add': (BuildContext context) => DeadlineAddView(),
      'icon': Icons.calendar_today,
    },
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade700,
        title: Text(
          _fragment[_index]['title'],
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Tambahkan fungsi membuka halaman tambah
              Get.to(_fragment[_index]['add'](context));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _fragment[_index]['view'](context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade700, Colors.lightBlue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue.shade900, Colors.lightBlue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightBlue.shade300,
                    child: Text(
                      "GN",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Geels No Counter",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Welcome!',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _fragment.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _index = i;
                      });
                      Get.back();
                    },
                    leading: Icon(_fragment[i]['icon'], color: Colors.white),
                    title: Text(
                      _fragment[i]['title'],
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    trailing: Icon(Icons.navigate_next, color: Colors.white),
                  );
                },
              ),
            ),
            Divider(color: Colors.white54),
            ListTile(
              onTap: () {
                logout(context); // Panggil fungsi logout
              },
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
              trailing: Icon(Icons.navigate_next, color: Colors.redAccent),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Text(
                "Version 1.0",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi logout
  void logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(
          context, '/login'); // Arahkan ke halaman login
    } catch (e) {
      print("Logout error: $e");
    }
  }
}
