import 'package:get/get.dart';

import '../../view/screens/FeaturesPages/BookMarkLectures.dart';
import '../../view/screens/FeaturesPages/RecentLectures.dart';

void goToBookMark() {
  Get.to(() => const BookMark(),
      transition: Transition.native,
      duration: const Duration(milliseconds: 600));
}

void goToRecentLectures() {
  Get.to(() => const RecentLectures(),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 450));
}
