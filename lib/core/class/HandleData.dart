import 'package:flutter/material.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';

class HandleData extends StatelessWidget {
  const HandleData(
      {Key? key,
      required this.dataState,
      required this.emptyWidget,
      required this.notEmptyWidget})
      : super(key: key);
  final DataState dataState;
  final Widget emptyWidget;
  final Widget notEmptyWidget;
  @override
  Widget build(BuildContext context) {
    return dataState == DataState.loading
        ? Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          )
        : dataState == DataState.empty
            ? emptyWidget
            : notEmptyWidget;
  }
}
