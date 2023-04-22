import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/theme/Theme.dart';
import 'core/Routes/routes.dart';
import 'core/services/Services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const LecturesOrganaizer());
}

class LecturesOrganaizer extends StatelessWidget {
  const LecturesOrganaizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool? isDarkMood =
        Hive.box(HiveBoxes.userDataBox).get(HiveKeys.isDarkMood);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      getPages: routes,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: isDarkMood == true ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
