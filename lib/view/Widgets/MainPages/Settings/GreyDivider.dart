import 'package:flutter/material.dart';

import '../../../../core/Constant/AppColors.dart';

class GreyDivider extends StatelessWidget {
  const GreyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.grey,
      height: 20,
      thickness: 2,
    );
  }
}
