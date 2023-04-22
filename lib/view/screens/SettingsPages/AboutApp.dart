import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/GreyDivider.dart';

import '../../../core/Constant/uiNumber.dart';
import '../../../core/functions/RichText/RichTextStyles.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      splashRadius: UINumbers.iconButtonRadius,
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "حول التطبيق",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                richTextDBlack(context, "اسم التطبيق: "),
                richTextBlack(context, "منسق المحاضرات\n\n"),
                richTextDBlack(context, "تاريخ الإنشاء: "),
                richTextBlack(context, '9/4/2023\n\n'),
                richTextDBlack(context, "الإصدار: "),
                richTextBlack(context, "v1.0.0\n\n"),
                richTextDBlack(context, "الجودة الحالية: "),
                richTextBlack(context, "50%")
              ])),
              const GreyDivider(),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                richTextGrey(context, "سياسة الخصوصية"),
                richTextDBlack(context,
                    "الخصوصية محفوظة في منسق المحاضرات حيث لا يمكن لأحد الوصول إلى اسم أو فرع أو أي شيء من بيانات المستخدم.\nحيث أن التطبيق لا يتطلب أي أتصال بالإنترنت.\n\n "),
                richTextGrey(context, "التفاعل مع المحاضرات"),
                richTextDBlack(context,
                    "1- لجعل المحاضرة منهاة الدراسة أضغط بأستمرار على ملف المحاضرة.\n2- لفتح معلومات المحاضرة أنقر نقرتين على ملف المحاضرة.\n3- عند حذف التطبيق لن يتم حذف ملف محاضراتي الذي يحتوي على المحاضرات التي تم حفظها من قبل المستخدم.\n\n4- لتوفير المساحة الدقيق يفضل أن يقوم المستخدم بمسح ذاكرة التخزين المؤقتة للتطبيق بين الحين والآخر وهذا لن يؤثر على تجربة المستخدم.\n\n"),
                richTextGrey(context, "مدة التطوير"),
                richTextDBlack(context,
                    "تم تطوير التطبيق خلال مدة زمنية قدرها ثلاثة أشهر ونصف تقريباً من قبل مجد ابرهيم.")
              ])),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
