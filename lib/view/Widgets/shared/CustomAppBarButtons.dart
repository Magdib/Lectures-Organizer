import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/Routes/routes.dart';

import '../../../core/Constant/static_data.dart';

class GoToBookMarkButton extends StatelessWidget {
  const GoToBookMarkButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.toNamed(AppRoutes.bookMarkRoute),
      icon: Icon(
        Icons.bookmark_border_outlined,
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
      splashRadius: StaticData.iconButtonRadius,
    );
  }
}

class GoToRecentButton extends StatelessWidget {
  const GoToRecentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.toNamed(AppRoutes.recentLecturesRoute),
      icon: Icon(
        Icons.update,
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
      splashRadius: StaticData.iconButtonRadius,
    );
  }
}
