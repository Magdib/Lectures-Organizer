import 'package:flutter/material.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/advancedFeatures/featuresAppBar.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/advancedFeatures/featuresListView.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/advancedFeatures/vipButton.dart';

class AdvancedFeaturePage extends StatelessWidget {
  const AdvancedFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeaturesAppBar(),
          SizedBox(
            height: 50,
          ),
          VipButton(),
          SizedBox(
            height: 10,
          ),
          FeaturesListView()
        ],
      ),
    );
  }
}
