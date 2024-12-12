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
      var snapshot =
          await FirebaseFirestore.instance.collection('mata_kuliah').get();
      mataKuliah.value = snapshot.docs.map((doc) {
        var data = doc.data();
        // Pastikan field 'tugas' ada
        return {
          'tugas':
              data.containsKey('tugas') ? data['tugas'] : 'Tidak ada tugas',
          'materi': data['materi'] ?? '',
          'deadline': data['deadline'] ?? '',
        };
      }).toList();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
