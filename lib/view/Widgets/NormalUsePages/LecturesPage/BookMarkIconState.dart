import 'package:flutter/material.dart';

import '../../../../core/Constant/AppColors.dart';

class BookMarkIconState extends StatelessWidget {
  const BookMarkIconState({
    super.key,
    required this.marked,
    required this.completed,
  });
  final bool marked;
  final bool completed;
  @override
  Widget build(BuildContext context) {
    return marked == false && completed == false
        ? const Icon(Icons.bookmark_add_outlined)
        : marked == true && completed == false
            ? const Icon(Icons.bookmark_remove_outlined)
            : marked == false && completed == true
                ? const Icon(
                    Icons.bookmark_add_outlined,
                    color: AppColors.white,
                  )
                : const Icon(
                    Icons.bookmark_remove_outlined,
                    color: AppColors.white,
                  );
  }
}
