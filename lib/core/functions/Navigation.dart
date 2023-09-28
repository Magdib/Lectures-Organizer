import 'package:get/get.dart';
import '../Routes/routes.dart';

void goToBookMark() {
  Get.toNamed(
    AppRoutes.bookMarkRoute,
  );
}

void goToRecentLectures() {
  Get.toNamed(
    AppRoutes.recentLecturesRoute,
  );
}
