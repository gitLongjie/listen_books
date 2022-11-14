import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listen_books/utils/net_utils.dart';
import 'package:listen_books/widget/flexible_detail_bar.dart';
import 'package:listen_books/widget/widget_music_list_header.dart';


class PlayListAppBarWidget extends StatelessWidget {
  final double expandedHeight;
  final Widget content;
  final String backgroundImg;
  final String title;
  final double sigma;
  final PlayModelCallback? playOnTap;
  final int count;

  const PlayListAppBarWidget({super.key, 
    required this.expandedHeight,
    required this.content,
    required this.title,
    required this.backgroundImg,
    this.sigma = 5,
    this.playOnTap,
    this.count = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      expandedHeight: expandedHeight,
      pinned: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      bottom: MusicListHeader(
        onTap: playOnTap!,
        count: count,
      ),
      flexibleSpace: FlexibleDetailBar(
        content: content,
        background: Stack(
          children: <Widget>[
            backgroundImg.startsWith('http')
                ? NetUtils.showNetImage(
                    '$backgroundImg?param=200y200',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    backgroundImg,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: sigma,
                sigmaX: sigma,
              ),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ), systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
