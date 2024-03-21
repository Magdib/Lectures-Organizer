import 'package:flutter/material.dart';
import 'package:unversityapp/core/Constant/static_data.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    Key? key,
    required this.whatisempty,
    required this.whatisempty1,
  }) : super(key: key);
  final String whatisempty;
  final String whatisempty1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: StaticData.deviceHeight / 10),
        child: Text(
          textAlign: TextAlign.center,
          'لا يوجد $whatisempty قم بإضافة $whatisempty1 من خلال الزر في الأسفل',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
