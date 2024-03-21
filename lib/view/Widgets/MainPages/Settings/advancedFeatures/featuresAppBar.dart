import 'package:flutter/material.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/Constant/static_data.dart';

import 'waveClipPath.dart';

class FeaturesAppBar extends StatelessWidget {
  const FeaturesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            color: Theme.of(context).primaryColor,
            height: 180,
          ),
        ),
        Positioned(
            top: 40,
            left: StaticData.deviceWidth / 5,
            child: Row(
              children: [
                Text(
                  "الميّزات المتقدمة",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Icon(
                    Icons.settings_suggest_outlined,
                    size: 40,
                    color: AppColors.white,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
