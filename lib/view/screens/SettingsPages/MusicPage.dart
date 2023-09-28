import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unversityapp/controller/settingsPagesController/musicController.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/music/MusicListView.dart';
import 'package:unversityapp/core/class/HandleData.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<MusicControllerimp>(
          builder: (controller) => HandleData(
            dataState: controller.dataState,
            loadingWidget: Center(
              child: Lottie.asset("assets/music.json", repeat: false),
            ),
            emptyWidget: Center(
              child: Text("لا يوجد موسيقى!!!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 20)),
            ),
            notEmptyWidget: const MusicListView(),
          ),
        ),
      ),
    );
  }
}
