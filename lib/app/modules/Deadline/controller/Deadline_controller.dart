import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeadlineController extends GetxController {
  //TODO: Implement DeadlineController
  late TextEditingController cNo_Deadline;
  late TextEditingController cMataKuliah_Deadline;
  late TextEditingController cDeadLine;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference Deadline = firestore.collection('Daftar_Deadline');

    return Deadline.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference Deadline = firestore.collection('Daftar_Deadline');
    return Deadline.snapshots();
  }

  void add(
      String no_Deadline, String nama_Matakuliah_Deadline, String DeadLine) async {
    CollectionReference Deadline = firestore.collection("Daftar_Deadline");

    try {
      await Deadline.add({
        "no_DeadLine": no_Deadline,
        "nama_matakuliah": nama_Matakuliah_Deadline,
        "DeadLine": DeadLine,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data DeadLine",
          onConfirm: () {
            cNo_Deadline.clear();
            cMataKuliah_Deadline.clear();
            cDeadLine.clear();
            Get.back();
            Get.back();
            textConfirm: "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Data DeadLine.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("Daftar_DeadLine").doc(id);

    return docRef.get();
  }

  void Update(String no_Deadline, String nama_Matakuliah_Deadline, String DeadLine,
      String id) async {
    DocumentReference DeadLineById =
        firestore.collection("Daftar_DeadLine").doc(id);

    try {
      await DeadLineById.update({
        "no": no_Deadline,
        "nama": nama_Matakuliah_Deadline,
        "jabatan": DeadLine,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data DeadLine.",
        onConfirm: () {
          cNo_Deadline.clear();
          cMataKuliah_Deadline.clear();
          cDeadLine.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Data DeadLine.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef =
        firestore.collection("Daftar_DeadLine").doc(id);

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
    cNo_Deadline = TextEditingController();
    cMataKuliah_Deadline = TextEditingController();
    cDeadLine = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNo_Deadline.dispose();
    cMataKuliah_Deadline.dispose();
    cDeadLine.dispose();
    super.onClose();
  }
}
