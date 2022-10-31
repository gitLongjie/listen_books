import 'package:flutter/material.dart';

class VEmptyView extends StatelessWidget {
  final double height;

  const VEmptyView(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
