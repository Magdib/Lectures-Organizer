import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/MainPagesControllers/HomePageController.dart';
import '../../../../core/Constant/ConstLists/YearsLists.dart';
import '../../../../core/Constant/AppColors.dart';

class ListViewofYears extends GetView<HomePageControllerimp> {
  const ListViewofYears({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: controller.numberofYears,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: MaterialButton(
              elevation: 5,
              color: Theme.of(context).buttonTheme.colorScheme!.background,
              padding: const EdgeInsets.all(0),
              onPressed: () => controller.nextPage(index),
              child: ListTile(
                title: Text(
                  years[index].year,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20),
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.lightblue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
