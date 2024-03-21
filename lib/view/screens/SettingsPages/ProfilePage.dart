import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/ProfileController.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/Profile/AddRemoveRow.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/Profile/SmartAverageData.dart';
import 'package:unversityapp/view/Widgets/shared/CustomAppBar.dart';
import 'package:unversityapp/view/Widgets/shared/CustomButton.dart';
import 'package:unversityapp/view/Widgets/shared/CustomTextField.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("البيانات الشخصية", context, enableActions: false),
      body: GetBuilder<ProfileControllerimp>(
        builder: (controller) => Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  CustomTextField(
                    label: 'الاسم',
                    hint: 'أدخل اسمك هنا...  (حرفين على الأقل)',
                    maxchar: StaticData.nameMaxChar,
                    editingController: controller.nameController,
                    onchange: (value) => controller.checkSaveState(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      label: 'الفرع',
                      hint:
                          'أدخل الفرع الذي تدرسه هنا... (أربع أحرف على الأقل)',
                      maxchar: StaticData.studyMaxChar,
                      editingController: controller.studyController,
                      onchange: (value) => controller.checkSaveState()),
                  const SizedBox(
                    height: 25,
                  ),
                  AddRemoveRow(
                    title: "السنة الحالية:",
                    value: "${controller.currentYear}",
                    addFunction: () => controller.addYear(true),
                    removeFunction: () => controller.removeYear(true),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AddRemoveRow(
                    title: "عدد السنوات:",
                    value: "${controller.numberOfYears}",
                    addFunction: () => controller.addYear(false),
                    removeFunction: () => controller.removeYear(false),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if (controller.anyDegree == false) const SmartAverageData()

                  // Text(
                  //   "في حالة عدم معرفة درجات المواد عبر السنين يوفّر المعدّل الذكي حساب معدل الطالب بناءً على عدد المواد ومعدله الحالي فعند إضافة أي مادة جديدة إلى قسم الدرجات يحسب تلقائياً المعدل الجديد",
                  //   style: Theme.of(context).textTheme.bodyText2,
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: CustomButton(
                  text: "حفظ البيانات",
                  onPressed:
                      controller.canSave ? () => controller.saveData() : null),
            ),
          ],
        ),
      ),
    );
  }
}
