import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/SubjectsPageController.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/core/functions/Dialogs/subjectsDialogs.dart';
import '../../../../core/Constant/AppColors.dart';
import '../../../../core/class/HandleData.dart';
import '../../shared/EmptyPageContent.dart';

class SubjectsList extends StatelessWidget {
  const SubjectsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectsPageControllerimp>(
      builder: (subjectscontroller) => Expanded(
          child: HandleData(
              dataState: subjectscontroller.dataState,
              emptyWidget: const EmptyPage(
                whatisempty: 'مواد',
                whatisempty1: 'مادة',
              ),
              notEmptyWidget: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MaterialButton(
                          splashColor: Theme.of(context).primaryColorDark,
                          height: 100,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          padding: const EdgeInsets.only(bottom: 15),
                          minWidth: double.infinity,
                          onPressed: () =>
                              subjectscontroller.goToLecturesPage(index),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                subjectscontroller
                                    .currentYearSubjects[index].subjectName!,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'عدد المحاضرات: ${subjectscontroller.currentYearSubjects[index].numberoflecture}\n${subjectscontroller.termIntToString(subjectscontroller.currentYearSubjects[index].term)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () =>
                                  subjectStateDialog(context, index),
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.white,
                              ),
                              splashRadius: StaticData.iconButtonRadius,
                            ),
                          ),
                        ),
                      ),
                  itemCount: subjectscontroller.currentYearSubjects.length))),
    );
  }
}
