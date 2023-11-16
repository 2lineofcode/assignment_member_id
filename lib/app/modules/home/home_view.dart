import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.lightbulb_fill, size: 48, color: Vx.yellow400).pOnly(bottom: 16),
            'Flutter Quiz App'.text.size(16).bold.make(),
            'Learn • Take Quiz • Repeat'.text.size(12).neutral300.make(),
            48.heightBox,
            ElevatedButton(
              child: 'PLAY'.text.make(),
              onPressed: () => controller.onPlay(),
            ).wh(250, 40),
            16.heightBox,
            OutlinedButton(
              child: 'TOPICS'.text.make(),
              onPressed: () => controller.goTopic(),
            ).wh(250, 40),
            32.heightBox,
            HStack(
              [
                TextButton.icon(
                  icon: Icon(Icons.share, size: 20),
                  label: 'Share'.text.white.make(),
                  onPressed: () {},
                ),
                16.widthBox,
                TextButton.icon(
                  icon: Icon(Icons.star, size: 20, color: Vx.yellow500),
                  label: 'Rate Us'.text.white.make(),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ).centered(),
      ),
    );
  }
}
