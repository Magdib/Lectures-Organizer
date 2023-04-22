import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/Constant/AppColors.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({
    Key? key,
    required this.title,
    required this.center,
    required this.circlepercent,
    required this.fontsize,
    required this.circleColor,
  }) : super(key: key);
  final String title;
  final String center;
  final double fontsize;
  final double circlepercent;
  final Color circleColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          height: 20,
        ),
        CircularPercentIndicator(
            animation: true,
            center: Text(center,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: fontsize)),
            backgroundColor: AppColors.lightBlack,
            percent: circlepercent,
            radius: 70,
            lineWidth: 20,
            progressColor: circleColor),
      ],
    );
  }
}
