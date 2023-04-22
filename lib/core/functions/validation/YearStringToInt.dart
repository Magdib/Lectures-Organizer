int numberofYearsToInt(String val) {
  int numberOfYears = 0;
  switch (val) {
    case 'سنتين':
      numberOfYears = 2;
      break;
    case 'ثلاث سنوات':
      numberOfYears = 3;
      break;
    case 'أربع سنوات':
      numberOfYears = 4;
      break;
    case 'خمس سنوات':
      numberOfYears = 5;
      break;
    case 'ست سنوات':
      numberOfYears = 6;
      break;
    default:
  }
  return numberOfYears;
}

int currentYearStringToInt(String val) {
  int currentYear = 0;
  switch (val) {
    case 'السنة الأولى':
      currentYear = 1;
      break;
    case 'السنة الثانية':
      currentYear = 2;
      break;
    case 'السنة الثالثة':
      currentYear = 3;
      break;
    case 'السنة الرابعة':
      currentYear = 4;
      break;
    case 'السنة الخامسة':
      currentYear = 5;
      break;
    case 'السنة السادسة':
      currentYear = 6;
      break;
    default:
  }
  return currentYear;
}
