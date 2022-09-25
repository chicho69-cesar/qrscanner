import 'package:flutter/material.dart';

class EmptyScans extends StatelessWidget {
  const EmptyScans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: Icon(
          Icons.add_a_photo_rounded,
          color: Theme.of(context).primaryColor,
          size: 120,
        ),
      ),
    );
  }
}
