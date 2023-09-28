import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/musicController.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/Constant/uiNumber.dart';
import 'package:unversityapp/core/functions/Dialogs/MusicInfoDialog.dart';
import 'package:unversityapp/view/Widgets/shared/CustomContainer.dart';

class MusicListView extends StatelessWidget {
  const MusicListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicControllerimp>(
      builder: (controller) => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        physics: controller.activeMusic
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        children: [
          CustomContainer(
            width: UINumbers.deviceWidth,
            height: 80,
            gradient: controller.activeMusic
                ? LinearGradient(colors: [
                    Theme.of(context).colorScheme.onSecondaryContainer,
                    Theme.of(context).colorScheme.onPrimaryContainer,
                    Theme.of(context).colorScheme.onSecondary,
                    Theme.of(context).colorScheme.onPrimary,
                  ], stops: const [
                    0.25,
                    0.5,
                    0.75,
                    1
                  ])
                : const LinearGradient(colors: [AppColors.grey], stops: [1]),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "موسيقى",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20),
                ),
                Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: controller.activeMusic,
                    onChanged: (val) => controller.changeMusicState(val))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          controller.activeMusic
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                        onDoubleTap: () => musicInfoDialog(context, index),
                        child: CustomContainer(
                          color: Theme.of(context).dialogBackgroundColor,
                          height: 60,
                          circularRadius: 10,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  controller.songs[index].displayName,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              MaterialButton(
                                padding: const EdgeInsets.all(0),
                                splashColor: Theme.of(context).primaryColor,
                                minWidth: 35,
                                height: 35,
                                shape: Theme.of(context).buttonTheme.shape,
                                disabledColor: Theme.of(context).primaryColor,
                                onPressed: () =>
                                    controller.addRemoveSongs(index),
                                color: controller.activeSongs[index] == true
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).scaffoldBackgroundColor,
                                child: Icon(
                                  Icons.check,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: controller.songs.length)
              : SizedBox(
                  height: UINumbers.deviceHeight - 200,
                  child: Center(
                    child: Text(
                      "الموسيقى أثناء الدراسة غير مفعّلة",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
