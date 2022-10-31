import 'package:flutter/material.dart';
import 'package:listen_books/widget/common_text_style.dart';

class PlayPageAppBarWidget extends StatefulWidget {
  final String title;
  final String artist;
  
  const PlayPageAppBarWidget({super.key, required this.title, required this.artist});
  
  @override
  State<StatefulWidget> createState() => _PlayPageAppBarWidgetState();
}

class _PlayPageAppBarWidgetState extends State<PlayPageAppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(widget.title, style: commonWhiteTextStyle,),
        Text(widget.artist, style: smallWhite70TextStyle,),
      ],
    );
  }
}