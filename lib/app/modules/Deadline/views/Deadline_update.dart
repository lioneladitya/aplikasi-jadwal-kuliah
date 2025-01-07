import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/modules/Deadline/controller/Deadline_controller.dart';

class DeadlineUpdate extends GetView<DeadlineController> {
  const DeadlineUpdate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Deadline'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cNo_Deadline.text = data['no_Deadline'];
            controller.cMataKuliah_Deadline.text =
                data['nama_Matakuliah_Deadline'];
            controller.cDeadLine.text = data['Deadline'];
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: controller.cNo_Deadline,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "no_Deadline"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cMataKuliah_Deadline,
                    textInputAction: TextInputAction.done,
                    decoration:
                        InputDecoration(labelText: "nama_Matakuliah_Deadline"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: controller.cDeadLine,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: "Deadline"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.Update(
                      controller.cNo_Deadline.text,
                      controller.cMataKuliah_Deadline.text,
                      controller.cDeadLine.text,
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
