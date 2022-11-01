import 'package:flutter/material.dart';
import 'package:listen_books/utils/net_utils.dart';

class RoundImgWidget extends StatelessWidget {
  final String img;
  final double width;
  final BoxFit fit;

  const RoundImgWidget(this.img, this.width, {super.key, required this.fit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width / 2),
      child: img.startsWith('http')
          ? NetUtils.showNetImage(img,
              width: width,
              height: width,
              fit: fit)
          : Image.asset(img, fit: fit,),
    );
  }
}
