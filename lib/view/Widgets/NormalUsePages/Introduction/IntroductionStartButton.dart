import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/introductionController.dart';
import '../../../../core/Constant/AppColors.dart';

class IntroductionStartButton extends StatelessWidget {
  const IntroductionStartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GetBuilder<IntroductionControllerimp>(
        builder: (controller) => MaterialButton(
          minWidth: double.infinity,
          height: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          disabledColor: AppColors.grey,
          color: AppColors.deepblue,
          onPressed:
              controller.isReady == true ? () => controller.nextPage() : null,
          child: Text(
            'هيا بنا',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
