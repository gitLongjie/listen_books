import 'package:flutter/material.dart';
import 'package:listen_books/widget/common_text_style.dart';
import 'package:listen_books/widget/v_empty_view.dart';

class NetErrorWidget extends StatelessWidget {
  final VoidCallback callback;

  const NetErrorWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.error_outline,
              size: 80,
            ),
            VEmptyView(10),
            Text(
              '点击重新请求',
              style: commonTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
