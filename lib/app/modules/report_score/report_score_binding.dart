import 'package:get/get.dart';

import 'report_score_controller.dart';

class ReportScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportScoreController>(() => ReportScoreController());
  }
}
