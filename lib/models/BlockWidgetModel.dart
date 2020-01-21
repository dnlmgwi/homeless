import 'package:flutter/material.dart';

class RewardWidget extends StatelessWidget {
  final String name;
  final String description;

  RewardWidget({this.name, this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$name'),
      subtitle: Text('$description'),
    );
  }
}
