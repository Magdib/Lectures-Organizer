import 'package:flutter/material.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';

class HandleData extends StatelessWidget {
  const HandleData(
      {Key? key,
      required this.dataState,
      required this.emptyWidget,
      required this.notEmptyWidget,
      this.loadingWidget})
      : super(key: key);
  final DataState dataState;
  final Widget emptyWidget;
  final Widget notEmptyWidget;
  final Widget? loadingWidget;
  @override
  Widget build(BuildContext context) {
    return dataState == DataState.loading
        ? loadingWidget ??
            Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
        : dataState == DataState.empty
            ? emptyWidget
            : notEmptyWidget;
  }
}
