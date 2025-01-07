import 'package:get/get.dart';

import '../controllers/Materi_controller.dart';

class MahasiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MateriController>(
      () => MateriController(),
    );
  }
}
