import 'package:get/get.dart';
import 'package:unversityapp/view/screens/FeaturesPages/BookMarkLectures.dart';
import 'package:unversityapp/view/screens/NormalUsePages/Introduction.dart';
import 'package:unversityapp/view/screens/FeaturesPages/RecentLectures.dart';
import 'package:unversityapp/view/screens/NormalUsePages/LecturesPage.dart';
import 'package:unversityapp/view/screens/NormalUsePages/MainPage.dart';
import 'package:unversityapp/view/screens/NormalUsePages/SubjectsPage.dart';
import 'package:unversityapp/view/screens/SettingsPages/DegreesPage.dart';
import 'package:unversityapp/view/screens/SettingsPages/AboutApp.dart';
import '../../view/screens/NormalUsePages/LectureView.dart';
import '../middleware/middleware.dart';

class AppRoutes {
  static const String mainPageRoute = '/MainPage';
  static const String homePageRoute = '/HomePage';
  static const String subjectPageRoute = '/SubjectPage';
  static const String bookMarkRoute = '/BookMark';
  static const String recentLecturesRoute = '/RecentLectures';
  static const String lecturesPageRoute = "/Lecturespage";
  static const String lectureViewRoute = "/LectureView";
  static const String degreesPageRoute = "/DegressPage";
  static const String aboutAppRoute = "/AboutAppPage";
}

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => Introduction(), middlewares: [MiddleWare()]),
  GetPage(name: AppRoutes.mainPageRoute, page: () => MainPage()),
  GetPage(name: AppRoutes.subjectPageRoute, page: () => const SubjectsPage()),
  GetPage(name: AppRoutes.bookMarkRoute, page: () => const BookMark()),
  GetPage(
      name: AppRoutes.recentLecturesRoute, page: () => const RecentLectures()),
  GetPage(name: AppRoutes.lecturesPageRoute, page: () => const LecturesPage()),
  GetPage(name: AppRoutes.lectureViewRoute, page: () => const LectureView()),
  GetPage(name: AppRoutes.degreesPageRoute, page: () => const DergreePage()),
  GetPage(name: AppRoutes.aboutAppRoute, page: () => const AboutApp())
];
