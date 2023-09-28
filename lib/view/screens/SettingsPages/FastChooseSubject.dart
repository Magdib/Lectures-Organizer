import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/FastModeController.dart';
import 'package:unversityapp/core/class/HandleData.dart';

class FastChooseSubject extends StatelessWidget {
  const FastChooseSubject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("أختر مادة", style: Theme.of(context).textTheme.headline1),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            )),
      ),
      body: GetBuilder<FastModeControllerimp>(
          builder: (controller) => HandleData(
                dataState: controller.dataState,
                emptyWidget: Center(
                  child: Text("لا يوجد مواد!!!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20)),
                ),
                notEmptyWidget: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.subjects.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 10),
                          child: MaterialButton(
                            splashColor: Theme.of(context).primaryColorDark,
                            height: 100,
                            color: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .onBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            minWidth: double.infinity,
                            onPressed: () => controller.chooseSubject(index),
                            child: Text(
                              controller.subjects[index].subjectName!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )),
              )),
    );
  }
}
