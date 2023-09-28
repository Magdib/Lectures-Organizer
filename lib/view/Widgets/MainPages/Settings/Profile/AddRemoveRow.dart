import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/ProfileController.dart';

class AddRemoveRow extends StatelessWidget {
  const AddRemoveRow({
    super.key,
    required this.title,
    required this.value,
    required this.addFunction,
    required this.removeFunction,
  });
  final String title;
  final String value;
  final void Function() addFunction;
  final void Function() removeFunction;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileControllerimp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
          ),
          IconButton(
              onPressed: addFunction,
              padding: EdgeInsets.zero,
              iconSize: 35,
              color: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.add_circle_outline_sharp,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              value,
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 30),
            ),
          ),
          IconButton(
              onPressed: removeFunction,
              padding: EdgeInsets.zero,
              iconSize: 35,
              color: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.remove_circle_outline_sharp,
              ))
        ],
      ),
    );
  }
}
