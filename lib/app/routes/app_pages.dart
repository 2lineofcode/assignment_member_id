import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/quiz/quiz_binding.dart';
import '../modules/quiz/quiz_view.dart';
import '../modules/report_score/report_score_binding.dart';
import '../modules/report_score/report_score_view.dart';
import '../modules/topics/topics_binding.dart';
import '../modules/topics/topics_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TOPICS,
      page: () => const TopicsView(),
      binding: TopicsBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_SCORE,
      page: () => const ReportScoreView(),
      binding: ReportScoreBinding(),
    ),
  ];
}
