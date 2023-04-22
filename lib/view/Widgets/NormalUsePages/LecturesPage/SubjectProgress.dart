import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:unversityapp/core/Constant/uiNumber.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';

class SubjectProgress extends StatelessWidget {
  const SubjectProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LecturePageControllerimp>(
      builder: (controller) => LinearPercentIndicator(
        animation: true,
        animateFromLastPercent: true,
        width: UINumbers.deviceWidth - 30,
        lineHeight: 7.0,
        percent: controller.percent,
        backgroundColor: Theme.of(context).primaryColorLight,
        progressColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
