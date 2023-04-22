int currentTermFunction(String termFilter) {
  late int currentTerm;
  switch (termFilter) {
    case "كِلا الفصلين":
      currentTerm = 0;
      break;
    case "الفصل الأول":
      currentTerm = 1;
      break;
    case "الفصل الثاني":
      currentTerm = 2;
      break;
    default:
  }
  return currentTerm;
}

String lectureTypeFunction(String lectureFilter) {
  late String lectureType;
  switch (lectureFilter) {
    case "عملي":
      lectureType = 'عملي';
      break;
    case "نظري":
      lectureType = 'نظري';
      break;
    case "الكل":
      lectureType = "الكل";
      break;
    default:
  }
  return lectureType;
}
