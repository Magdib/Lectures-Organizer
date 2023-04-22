import 'package:flutter/material.dart';

import '../../../core/Constant/uiNumber.dart';
import '../../../core/functions/Navigation.dart';

class GoToBookMarkButton extends StatelessWidget {
  const GoToBookMarkButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => goToBookMark(),
      icon: Icon(
        Icons.bookmark_border_outlined,
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
      splashRadius: UINumbers.iconButtonRadius,
    );
  }
}

class GoToRecentButton extends StatelessWidget {
  const GoToRecentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => goToRecentLectures(),
      icon: Icon(
        Icons.update,
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
      splashRadius: UINumbers.iconButtonRadius,
    );
  }
}
