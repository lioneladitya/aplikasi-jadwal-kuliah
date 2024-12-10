import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_add_view.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_view.dart';

import '../controllers/home_controller.dart';

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
  final List<Map> _fragment = [
    {
      'title': 'Mata Kuliah',
      'view': (context) => MahasiswaView(type: 'mata_kuliah'), // Replace with your MahasiswaView
      'add': () => MahasiswaAddView(type: 'mata_kuliah'), // Replace with your MahasiswaAddView
    },
    {
      'title': 'Daftar Tugas',
      'view': (context) => MahasiswaView(type: 'tugas'), // Replace with your MahasiswaView
      'add': () => MahasiswaAddView(type: 'tugas'), // Replace with your MahasiswaAddView
    },
    {
      'title': 'Pencatatan Materi',
      'view': (context) => MahasiswaView(type: 'materi'), // Replace with your MahasiswaView
      'add': () => MahasiswaAddView(type: 'materi'), // Replace with your MahasiswaAddView
    },
    {
      'title': 'Daftar Deadline',
      'view': (context) => MahasiswaView(type: 'deadline'), // Replace with your MahasiswaView
      'add': () => MahasiswaAddView(type: 'deadline'), // Replace with your MahasiswaAddView
    },
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal.shade700,
        title: Text(
          _fragment[_index]['title'],
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: "Add New",
            onPressed: () => Get.to(_fragment[_index]['add']()),
            icon: Icon(Icons.add_circle, size: 28),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _fragment[_index]['view'](context),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.teal.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade900, Colors.teal.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.teal.shade300,
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
            ...List.generate(
              _fragment.length,
              (i) => ListTile(
                onTap: () {
                  setState(() => _index = i);
                  Get.back();
                },
                leading: Icon(Icons.dashboard, color: Colors.white),
                title: Text(
                  _fragment[i]['title'],
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.navigate_next, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Get.back();
                // Add logout logic here
              },
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.navigate_next, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
