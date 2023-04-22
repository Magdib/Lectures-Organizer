List<String> currentYearValidation(String val) {
  List<String> currentYearList = [];
  switch (val) {
    case 'سنتين':
      currentYearList = [
        'السنة الأولى',
        'السنة الثانية',
      ];
      break;
    case 'ثلاث سنوات':
      currentYearList = [
        'السنة الأولى',
        'السنة الثانية',
        'السنة الثالثة',
      ];
      break;
    case 'أربع سنوات':
      currentYearList = [
        'السنة الأولى',
        'السنة الثانية',
        'السنة الثالثة',
        'السنة الرابعة',
      ];
      break;
    case 'خمس سنوات':
      currentYearList = [
        'السنة الأولى',
        'السنة الثانية',
        'السنة الثالثة',
        'السنة الرابعة',
        'السنة الخامسة',
      ];
      break;
    case 'ست سنوات':
      currentYearList = [
        'السنة الأولى',
        'السنة الثانية',
        'السنة الثالثة',
        'السنة الرابعة',
        'السنة الخامسة',
        'السنة السادسة'
      ];
      break;
    default:
  }
  return currentYearList;
}

String yearToStringfunction(int currentyear, int numberOfYears) {
  String currentYearToWord = '';

  if (currentyear == 1) {
    currentYearToWord = 'السنة الأولى';
  } else if (currentyear == 2) {
    currentYearToWord = 'السنة الثانية';
  } else if (currentyear == 3) {
    currentYearToWord = 'السنة الثالثة';
  } else if (currentyear == 4) {
    currentYearToWord = 'السنة الرابعة';
  } else if (currentyear == 5) {
    currentYearToWord = 'السنة الخامسة';
  } else if (currentyear == 6) {
    currentYearToWord = 'السنة السادسة';
  }
  return currentYearToWord;
}

String yearWordFunction(int currentyear, int numberOfYears) {
  String firstyearword = 'تذكر رحلة الألف ميل تبدأ بخطوة';
  String secondYearWord = 'من يخطو خطوة يخطو ألف';
  String midYearWord = 'وصلنا إلى نصف الطريق';
  String endNearYearWord = 'إقتربنا من نهاية الطريق';
  String lastYearWord = 'خطوة واحدة متبقية';
  String sixyearuniqueword = 'أحسنت، تابع تقدمك!';
  String yearword = '';
  //------------------------------------------------ 6 Years----------------------------------------------------------------
  if (numberOfYears == 6) {
    if (currentyear == 1) {
      yearword = firstyearword;
    } else if (currentyear == 2) {
      yearword = secondYearWord;
    } else if (currentyear == 3) {
      yearword = sixyearuniqueword;
    } else if (currentyear == 4) {
      yearword = midYearWord;
    } else if (currentyear == 5) {
      yearword = endNearYearWord;
    } else if (currentyear == 6) {
      yearword = lastYearWord;
    }
  } //------------------------------------------------ 5 Years----------------------------------------------------------------
  else if (numberOfYears == 5) {
    if (currentyear == 1) {
      yearword = firstyearword;
    } else if (currentyear == 2) {
      yearword = secondYearWord;
    } else if (currentyear == 3) {
      yearword = midYearWord;
    } else if (currentyear == 4) {
      yearword = endNearYearWord;
    } else if (currentyear == 5) {
      yearword = lastYearWord;
    }
  }
  //------------------------------------------------ 4 Years----------------------------------------------------------------
  else if (numberOfYears == 4) {
    if (currentyear == 1) {
      yearword = firstyearword;
    } else if (currentyear == 2) {
      yearword = secondYearWord;
    } else if (currentyear == 3) {
      yearword = endNearYearWord;
    } else if (currentyear == 4) {
      yearword = lastYearWord;
    }
  } //------------------------------------------------ 3 Years----------------------------------------------------------------
  else if (numberOfYears == 3) {
    if (currentyear == 1) {
      yearword = firstyearword;
    } else if (currentyear == 2) {
      yearword = midYearWord;
    } else if (currentyear == 3) {
      yearword = lastYearWord;
    }
  }
  //------------------------------------------------ 2 Years----------------------------------------------------------------
  else if (numberOfYears == 2) {
    if (currentyear == 1) {
      yearword = firstyearword;
    } else if (currentyear == 2) {
      yearword = lastYearWord;
    }
  }
  return yearword;
}
