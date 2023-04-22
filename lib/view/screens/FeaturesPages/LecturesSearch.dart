import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/FeaturePagesControllers/LecturesSearchController.dart';
import '../../Widgets/FeaturesPages/SearchBody.dart';

class LecturesSearch extends SearchDelegate {
  LecturesSearch()
      : super(
          searchFieldLabel: "أكتب اسم المحاضرة هنا",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  final LectureSearchControllerimp controller = Get.find();
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        color: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headline2,
      ),
      textTheme: TextTheme(
        headline6: Theme.of(context).textTheme.bodyText1,
      ),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context).textTheme.bodyText1,
          border: InputBorder.none),
    );
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.close,
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, {});
        },
        icon: const Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchBody(
        query: query, filtredLectures: controller.filterdLectrues);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (controller.where != 0) controller.filterLectures(query);
    return SearchBody(
      query: query,
      filtredLectures: controller.filterdLectrues,
    );
  }
}
