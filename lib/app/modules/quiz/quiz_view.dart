import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/app_themes.dart';
import '../../models/quiz_model.dart';
import 'quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Quiz - ${controller.topicSelected.value}')),
        actions: [
          TextButton(
            onPressed: () => controller.exitQuiz(),
            child: 'Exit'.text.neutral300.bold.make(),
          ),
        ],
      ),
      body: controller.obx(
        (state) => VStack(
          [
            /// question info like timer, etc.
            buildQuestionInfo().pOnly(bottom: 16),

            /// question
            buildQuestion().pOnly(bottom: 24),

            /// options
            for (var option in controller.currentQuestion.value.options!) ...[
              buildOptions(option),
            ],

            Spacer(),

            /// button next/done
            buildNextOrSubmit(context),
          ],
        ).p16(),
      ),
    );
  }

  Widget buildQuestionInfo() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.appbarColor, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: HStack(
        [
          Obx(() => 'Question: ${controller.currentQuestionIndex.value + 1}/${controller.questionList.length}'.text.bold.make()),
          Spacer(),
          Obx(
            () => Container(
              decoration: BoxDecoration(color: AppColor.buttonColor, borderRadius: BorderRadius.all(Radius.circular(90))),
              child: HStack(
                [
                  Icon(CupertinoIcons.time_solid, size: 20).pOnly(right: 8),
                  '${controller.currentTimer.value} Second'.text.size(12).bold.make(),
                ],
              ).pSymmetric(v: 4, h: 8),
            ),
          ),
        ],
      ).p12(),
    );
  }

  Widget buildQuestion() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: VStack(
        [
          /// question
          '${controller.currentQuestion.value.question}'.text.bold.size(16).black.make().pOnly(bottom: 8),

          /// media
          if (controller.currentQuestion.value.media.isNotEmptyAndNotNull) ...[
            Image.network(
              '${controller.currentQuestion.value.media}',
              fit: BoxFit.fitWidth,
              height: 200,
              width: double.infinity,
            ),
          ],
        ],
      ).p12(),
    );
  }

  Widget buildOptions(Options option) {
    return VStack(
      [
        Obx(
          () => RadioListTile(
            contentPadding: EdgeInsets.zero,
            value: option,
            groupValue: controller.currentUserAnswer.value,
            title: '${option.title}'.text.white.make(),
            onChanged: (value) {
              print('value: ${jsonEncode(value)}');
              controller.currentUserAnswer.value = value!;
            },
          ),
        ),
      ],
    );
  }

  Widget buildNextOrSubmit(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        child: controller.currentQuestionIndex.value < controller.questionList.length - 1 //
            ? 'Next Question'.text.make()
            : 'Submit'.text.make(),
        onPressed: () => controller.currentQuestionIndex.value < controller.questionList.length - 1 //
            ? controller.onNextQuestion()
            : controller.onSubmitAnswer(),
      ).pSymmetric(h: 24, v: 24).wFull(context),
    );
  }
}
