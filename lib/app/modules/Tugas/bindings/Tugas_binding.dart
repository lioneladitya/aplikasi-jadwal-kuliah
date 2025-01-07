import 'package:get/get.dart';

import '../controllers/Tugas_controller.dart';

class MahasiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasController>(
      () => TugasController(),
    );
  }
}
