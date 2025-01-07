import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MateriController extends GetxController {
  //TODO: Implement MateriController
  late TextEditingController cNo_Materi;
  late TextEditingController cMataKuliah_Materi;
  late TextEditingController cMateri;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference Materi = firestore.collection('Daftar_Materi');

    return Materi.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference Materi = firestore.collection('Daftar_Materi');
    return Materi.snapshots();
  }

  void add(
      String no_Materi, String nama_Matakuliah_Materi, String Materi) async {
    CollectionReference Materi = firestore.collection("Daftar_Materi");

    try {
      await Materi.add({
        "no_materi": no_Materi,
        "nama_matakuliah": nama_Matakuliah_Materi,
        "Materi": Materi,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data Materi",
          onConfirm: () {
            cNo_Materi.clear();
            cMataKuliah_Materi.clear();
            cMateri.clear();
            Get.back();
            Get.back();
            textConfirm: "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Data Materi.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("Daftar_Materi").doc(id);

    return docRef.get();
  }

  void Update(String no_Materi, String nama_Matakuliah_Materi, String Materi,
      String id) async {
    DocumentReference MateriById =
        firestore.collection("Daftar_Materi").doc(id);

    try {
      await MateriById.update({
        "no": no_Materi,
        "nama": nama_Matakuliah_Materi,
        "jabatan": Materi,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data Materi.",
        onConfirm: () {
          cNo_Materi.clear();
          cMataKuliah_Materi.clear();
          cMateri.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Data Materi.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef =
        firestore.collection("Daftar_Materi").doc(id);

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
    cNo_Materi = TextEditingController();
    cMataKuliah_Materi = TextEditingController();
    cMateri = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNo_Materi.dispose();
    cMataKuliah_Materi.dispose();
    cMateri.dispose();
    super.onClose();
  }
}
