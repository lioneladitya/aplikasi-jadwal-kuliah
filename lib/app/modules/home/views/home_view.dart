import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_add_view.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_view.dart';
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
      'add': () => MahasiswaAddView(type: 'mata_kuliah'),
      'icon': Icons.school,
    },
    {
      'title': 'Daftar Tugas',
      'view': (BuildContext context) => MahasiswaView(type: 'tugas'),
      'add': () => MahasiswaAddView(type: 'tugas'),
      'icon': Icons.task,
    },
    {
      'title': 'Pencatatan Materi',
      'view': (BuildContext context) => MahasiswaView(type: 'materi'),
      'add': () => MahasiswaAddView(type: 'materi'),
      'icon': Icons.note_alt,
    },
    {
      'title': 'Daftar Deadline',
      'view': (BuildContext context) => MahasiswaView(type: 'deadline'),
      'add': () => MahasiswaAddView(type: 'deadline'),
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
            tooltip: "Add New",
            onPressed: () {
              Widget? addView = _fragment[_index]['add']();
              if (addView != null) Get.to(addView);
            },
            icon: Icon(Icons.add_circle, size: 28),
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
                  colors: [
                    Colors.lightBlue.shade900,
                    Colors.lightBlue.shade700
                  ],
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
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
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
                        'Admin',
                        style: TextStyle(fontSize: 14, color: Colors.white),
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
            ListTile(
              title: Text(
                "Version 1.0",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
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
