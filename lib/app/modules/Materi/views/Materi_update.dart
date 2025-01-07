import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/modules/Materi/controllers/Materi_controller.dart';

class MateriUpdate extends GetView<MateriController> {
  const MateriUpdate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Materi'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cNo_Materi.text = data['no_Materis'];
            controller.cMataKuliah_Materi.text = data['nama_Matakuliah_Materi'];
            controller.cMateri.text = data['Materi'];
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: controller.cNo_Materi,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "no_Materi"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cMataKuliah_Materi,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: "nama_Matakuliah_Materi"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: controller.cMateri,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: "Materi"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.Update(
                      controller.cNo_Materi.text,
                      controller.cMataKuliah_Materi.text,
                      controller.cMateri.text,
                      Get.arguments,
                    ),
                    child: Text("Ubah"),
                  )
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
