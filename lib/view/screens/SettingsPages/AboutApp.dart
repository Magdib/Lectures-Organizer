import 'package:flutter/material.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/GreyDivider.dart';
import 'package:unversityapp/view/Widgets/shared/CustomAppBar.dart';

import '../../../core/functions/RichText/RichTextStyles.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar("حول التطبيق", context, enableActions: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                richTextDBlack(context, "اسم التطبيق: "),
                richTextBlack(context, "منسق المحاضرات\n\n"),
                richTextDBlack(context, "تاريخ الإنشاء: "),
                richTextBlack(context, '4/10/2022\n\n'),
                richTextDBlack(context, "تاريخ آخر تحديث: "),
                richTextBlack(context, '21/3/2024\n\n'),
                richTextDBlack(context, "الإصدار: "),
                richTextBlack(context, "v1.2.0\n\n"),
                richTextDBlack(context, "الجودة الحالية: "),
                richTextBlack(context, "75%")
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
                    "1- لجعل المحاضرة منهاة الدراسة أضغط بأستمرار على ملف المحاضرة.\n2- لفتح معلومات المحاضرة أنقر نقرتين على ملف المحاضرة.\n3- عند حذف التطبيق لن يتم حذف ملف منسق المحاضرات الذي يحتوي على المحاضرات التي تم حفظها من قبل المستخدم.\n\n4- لتوفير المساحة الدقيق يفضل أن يقوم المستخدم بمسح ذاكرة التخزين المؤقتة للتطبيق بين الحين والآخر وهذا لن يؤثر على تجربة المستخدم.\n\n"),
                richTextGrey(context, "المعدّل الذكي"),
                richTextDBlack(context,
                    "يقوم المعدل الذكي بحساب المعدّل المستقبلي بناءً على عدد المواد والمعدل الحالي\n\nمثلاً: طالب في السنة الرابعة لا يعلم درجات مواده أو لا يريد إضافة جميع درجاته في السنين السابقة للحصول على المعدل فيقوم بكتابة معدله الحالي وعدد المواد التي نجح فيها وبناءً على هذا المعدل عند إضافة أي مادة جديدة يتم حساب المعدل الكلي الجديد مع العلم بأن المعدل الذكي غير متوفر في حالة إضافة درجة أي مادة.\n\n"),
                richTextGrey(context, "عملية التطوير"),
                richTextDBlack(context, "تم تطوير التطبيق من قبل مجد ابرهيم.")
              ])),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
