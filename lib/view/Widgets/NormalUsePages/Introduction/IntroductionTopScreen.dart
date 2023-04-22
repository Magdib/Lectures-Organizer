import 'package:flutter/material.dart';

import '../../../../core/Constant/AppColors.dart';

class IntroductionTopScreen extends StatelessWidget {
  const IntroductionTopScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.verylightBlue,
      child: Column(
        children: [
          Text(
            'منسق المحاضرات',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            child: Image.asset('images/intro.jpg'),
          ),
        ],
      ),
    );
  }
}
