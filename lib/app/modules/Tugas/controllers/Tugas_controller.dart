import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TugasController extends GetxController {
  //TODO: Implement TugasController
  late TextEditingController cNo;
  late TextEditingController cMataKuliah;
  late TextEditingController cTugas;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference Tugas = firestore.collection('Daftar_Tugas');

    return Tugas.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference Tugas = firestore.collection('Daftar_Tugas');
    return Tugas.snapshots();
  }

  void add(
      String no_Tugas, String nama_Matakuliah, String Tugas) async {
    CollectionReference Tugas = firestore.collection("Daftar_Tugas");

    try {
      await Tugas.add({
        "no": no_Tugas,
        "nama": nama_Matakuliah,
        "jabatan": Tugas,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data Tugas",
          onConfirm: () {
            cNo.clear();
            cMataKuliah.clear();
            cTugas.clear();
            Get.back();
            Get.back();
            textConfirm: "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Data Tugas.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("dosen").doc(id);

    return docRef.get();
  }

  void Update(String no_Tugas, String nama_Matakuliah, String Tugas,
      String id) async {
    DocumentReference TugasById =
        firestore.collection("Daftar_Tugas").doc(id);

    try {
      await TugasById.update({
        "no": no_Tugas,
        "nama": nama_Matakuliah,
        "jabatan": Tugas,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data Tugas.",
        onConfirm: () {
          cNo.clear();
          cMataKuliah.clear();
          cTugas.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Data Tugas.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef =
        firestore.collection("Daftar_Tugas").doc(id);

    try {
      Get.defaultDialog(
        title: "Info",
        middleText: "Apakah anda yakin menghapus data ini ?",
        onConfirm: () {
          docRef.delete();
          Get.back();
          Get.defaultDialog(
            title: "Sukses",
            middleText: "Berhasil menghapus data",
          );
        },
        textConfirm: "Ya",
        textCancel: "Batal",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Tidak berhasil menghapus data",
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cNo = TextEditingController();
    cMataKuliah = TextEditingController();
    cTugas = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNo.dispose();
    cMataKuliah.dispose();
    cTugas.dispose();
    super.onClose();
  }
}
