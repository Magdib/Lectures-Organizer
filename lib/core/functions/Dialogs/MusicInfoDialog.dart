import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/musicController.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

import '../RichText/RichTextStyles.dart';

musicInfoDialog(BuildContext context, int index) {
  MusicControllerimp controller = Get.find();
  return Get.defaultDialog(
      titleStyle: Theme.of(context).textTheme.headline1,
      title: 'تفاصيل الأغنية',
      onWillPop: () => controller.onwillpopInfo(),
      content: RichText(
          text: TextSpan(children: <TextSpan>[
        richTextDBlack(context, "الاسم: "),
        richTextBlack(context, " ${controller.songs[index].displayName}\n\n"),
        richTextDBlack(context, "المسار: "),
        richTextBlack(context, "${controller.songs[index].data}\n\n"),
      ])),
      cancel: DialogButton(
        text: "خروج",
        onPressed: () => controller.onwillpopInfo(),
      ),
      confirm: GetBuilder<MusicControllerimp>(
        builder: (controller) => DialogButton(
          text: controller.musicPlaying ? "إيقاف" : 'تشغيل',
          onPressed: () {
            controller.testMusic(index);
          },
        ),
      ));
}
