import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/FastModeController.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/class/HandleData.dart';

class FastModePage extends StatelessWidget {
  const FastModePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FastModeControllerimp());
    return GetBuilder<FastModeControllerimp>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "الوضع السريع",
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
          ),
          leading: IconButton(
              onPressed: () => controller.exitFastMode(),
              enableFeedback: true,
              tooltip: "الخروج من الوضع السريع",
              icon: Icon(
                Icons.flash_off_outlined,
                color: Theme.of(context).primaryColor,
              )),
          actions: [
            IconButton(
                onPressed: () => controller.changeMusicState(),
                tooltip: controller.activeMusic
                    ? "الموسيقى فعّالة"
                    : "الموسيقى ملغاة",
                icon: Icon(
                  controller.activeMusic ? Icons.music_note : Icons.music_off,
                  color: Theme.of(context).primaryColor,
                ))
          ],
          centerTitle: true,
        ),
        body: HandleData(
          dataState: controller.dataState,
          emptyWidget: Center(
            child: Text("لا يوجد محاضرات!!!",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 20)),
          ),
          notEmptyWidget: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.currentLectures.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    child: MaterialButton(
                      splashColor: Theme.of(context).primaryColor,
                      height: 100,
                      color: controller.currentLectures[index].check
                          ? Theme.of(context).primaryColor
                          : Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      minWidth: double.infinity,
                      onPressed: () => controller.openLecture(index),
                      onLongPress: () => controller.completeLecture(index),
                      child: Text(
                        controller.currentLectures[index].lecturename,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16,
                            color: controller.currentLectures[index].check
                                ? AppColors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
