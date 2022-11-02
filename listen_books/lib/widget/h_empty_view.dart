import 'package:flutter/material.dart';

class HEmptyView extends StatelessWidget {
  final double width;

  const HEmptyView(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,);
  }
}
