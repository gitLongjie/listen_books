
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen_books/utils/net_utils.dart';

class RoundedNetImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double radius;
  final BoxFit? fit;

  const RoundedNetImage(this.url, {super.key, this.width = 100, this.height = 100, this.radius = 10, this.fit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(radius))),
      child: NetUtils.showNetImage(
        url,
        width: ScreenUtil().setWidth(width),
        height: ScreenUtil().setWidth(height),
        fit: fit
      ),
    );
  }
}
