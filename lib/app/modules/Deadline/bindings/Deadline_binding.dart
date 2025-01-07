import 'package:get/get.dart';
import 'package:myapp/app/modules/Deadline/controller/Deadline_controller.dart';

import '../controller/Deadline_controller.dart';

class MahasiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeadlineController>(
      () => DeadlineController(),
    );
  }
}
