// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:myapp/app/modules/Tugas/controllers/Tugas_controller.dart';

// class TugasUpdate extends GetView<TugasController> {
//   const TugasUpdate({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ubah Tugas'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<DocumentSnapshot<Object?>>(
//         future: controller.getData(Get.arguments),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             var data = snapshot.data!.data() as Map<String, dynamic>;
//             controller.cNo.text = data['no_Tugas'];
//             controller.cMataKuliah.text = data['nama_Matakuliah'];
//             controller.cTugas.text = data['Tugas'];
//             return Padding(
//               padding: EdgeInsets.all(8),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: controller.cNo,
//                     autocorrect: false,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(labelText: "no_Tugas"),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: controller.cMataKuliah,
//                     textInputAction: TextInputAction.done,
//                     decoration: InputDecoration(labelText: "nama_Matakuliah"),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   TextField(
//                     controller: controller.cTugas,
//                     textInputAction: TextInputAction.done,
//                     decoration: InputDecoration(labelText: "Tugas"),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   ElevatedButton(
//                     onPressed: () => controller.Update(
//                       controller.cNo.text,
//                       controller.cMataKuliah.text,
//                       controller.cTugas.text,
//                       Get.arguments,
//                     ),
//                     child: Text("Ubah"),
//                   )
//                 ],
//               ),
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
