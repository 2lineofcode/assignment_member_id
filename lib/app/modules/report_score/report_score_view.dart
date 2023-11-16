import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/app_themes.dart';
import '../../models/quiz_model.dart';
import 'report_score_controller.dart';

class ReportScoreView extends GetView<ReportScoreController> {
  const ReportScoreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report Score')),
      body: VStack(
        [
          /// header
          summaries().pOnly(bottom: 24, top: 16),

          /// list questions
          ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: controller.reportUserAnswered.length,
            itemBuilder: (context, index) {
              final item = controller.reportUserAnswered[index];
              return questionItems(item);
            },
          ).expand(),
        ],
      ).p8(),
    );
  }

  Container summaries() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.appbarColor, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: HStack(
        [
          Obx(
            () => SimpleCircularProgressBar(
              progressColors: [Colors.green],
              progressStrokeWidth: 4,
              backColor: Colors.black,
              fullProgressColor: Colors.pink,
              animationDuration: 2,
              backStrokeWidth: 9,
              mergeMode: true,
              size: 70,
              valueNotifier: ValueNotifier(controller.countCorrectAnswer.value / controller.reportUserAnswered.length * 100),
              onGetText: (score) {
                return Text('${score.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold));
              },
            ),
          ),
          24.widthBox,
          VStack([
            'Score: ${(controller.countCorrectAnswer.value / controller.reportUserAnswered.length * 100).toStringAsFixed(0)}'.text.size(16).bold.make(),
            '${controller.countCorrectAnswer.value}/${controller.reportUserAnswered.length} Correct'.text.make(),
          ]),
          Spacer(),
          TextButton.icon(
            onPressed: () => controller.share(),
            icon: Icon(Icons.share),
            label: 'Share'.text.make(),
          ),
        ],
      ).p12(),
    );
  }

  ListTile questionItems(QuizModel item) {
    return ListTile(
      title: '${item.question}'.text.size(16).minFontSize(16).maxLines(1).ellipsis.bold.make().pOnly(bottom: 8),
      subtitle: VStack(
        [
          /// row user answer
          HStack([
            item.userAnswer?.isCorrect == true //
                ? Icon(Icons.check, color: Colors.green, size: 20).pOnly(right: 8)
                : Icon(Icons.close, color: Colors.red, size: 20).pOnly(right: 8),
            '${item.userAnswer?.title}'.text.size(12).make().expand(),
          ]),

          /// row correct answer (only show when user wrong answer)
          if (item.userAnswer?.isCorrect == false) ...[
            HStack([
              Icon(Icons.check, color: Colors.green, size: 20).pOnly(right: 8),
              for (var option in item.options!) ...[
                if (option.isCorrect == true) ...[
                  '${option.title}'.text.size(12).make().expand(),
                ]
              ]
            ]),
          ],
        ],
      ),
      trailing: item.userAnswer?.isCorrect == true
          ? Container(
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(90))),
              child: 'Correct'.text.make().pSymmetric(v: 4, h: 8),
            )
          : Container(
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(90))),
              child: 'Wrong'.text.make().pSymmetric(v: 4, h: 8),
            ),
    );
  }
}
