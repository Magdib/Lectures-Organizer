import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/MainPagesControllers/HomePageController.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/view/Widgets/shared/CustomAppBarButtons.dart';

class HomePageAppBar extends GetView<HomePageControllerimp> {
  const HomePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const GoToBookMarkButton(),
        Text(
          'الصفحة الرئيسية',
          style: Theme.of(context).textTheme.headline1,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.date_range,
            size: 27.5,
            color: Theme.of(context).primaryColor,
          ),
          splashRadius: StaticData.iconButtonRadius,
        ),
        const GoToRecentButton()
      ],
    );
  }
}
