import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/introductionController.dart';
import '../../../core/Constant/AppColors.dart';
import '../../Widgets/NormalUsePages/Introduction/IntroductionDropDownButtons.dart';
import '../../Widgets/NormalUsePages/Introduction/IntroductionStartButton.dart';
import '../../Widgets/NormalUsePages/Introduction/IntroductionTopScreen.dart';
import '../../Widgets/shared/TextFormField.dart';

class Introduction extends StatelessWidget {
  Introduction({Key? key}) : super(key: key);
  final IntroductionControllerimp controller =
      Get.put(IntroductionControllerimp());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Listener(
          onPointerDown: (_) => controller.dropDownButtonFix(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IntroductionTopScreen(),
                    Text(
                      ' هيا نبدأ الدراسة',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    CustomTextField(
                      hint: 'أدخل اسمك هنا...  (ثلاث أحرف على الأقل)',
                      maxchar: 14,
                      editingController: controller.nameController,
                      onchange: (value) => controller.enableDropDownButton(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hint:
                          'أدخل الفرع الذي تدرسه هنا... (أربع أحرف على الأقل)',
                      maxchar: 36,
                      editingController: controller.studyController,
                      onchange: (value) => controller.enableDropDownButton(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('أدخل عدد السنوات في فرعك في الأسفل هنا:',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 16)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const IntroductionDropDownButtons(),
                    const IntroductionStartButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
