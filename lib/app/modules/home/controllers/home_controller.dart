import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Daftar mata kuliah
  var mataKuliah = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMataKuliah(); // Panggil fungsi untuk fetch data
  }

  void fetchMataKuliah() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('mata_kuliah').get();
      mataKuliah.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>; // Pastikan tipe data sesuai
        return {
          'tugas': data['tugas'] ?? 'Tidak ada tugas',  // Pastikan field 'tugas' ada
          'materi': data['materi'] ?? '',  // Default ke empty string jika tidak ada materi
          'deadline': data['deadline'] ?? '', // Default ke empty string jika tidak ada deadline
        };
      }).toList();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
