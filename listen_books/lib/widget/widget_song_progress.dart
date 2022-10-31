import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:listen_books/model/play_songs_model.dart';
import 'package:listen_books/widget/common_text_style.dart';

class SongProgressWidget extends StatelessWidget {
  final PlaySongsModel model;

  const SongProgressWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: model.curPositionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var totalTime =
          snapshot.data!.substring(snapshot.data!.indexOf('-') + 1);
          var curTime = double.parse(snapshot.data!.substring(0, snapshot.data!.indexOf('-')));
          var curTimeStr = DateUtil.formatDateMs(curTime.toInt(), format: "mm:ss");
          return buildProgress(curTime, totalTime, curTimeStr);
        } else {
          return buildProgress(0, "0", "00:00");
        }
      },
    );
  }

  Widget buildProgress(double curTime, String totalTime, String curTimeStr){
    return SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          Text(
            curTimeStr,
            style: smallWhiteTextStyle,
          ),
          Expanded(
            child: SliderTheme(
              data: const SliderThemeData(
                trackHeight: 2,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 10,
                ),
              ),
              child: Slider(
                value: curTime,
                onChanged: (data) {
                  // model.sinkProgress(data.toInt());
                },
                onChangeStart: (data) {
                  // model.pausePlay();
                },
                onChangeEnd: (data) {
                  // model.seekPlay(data.toInt());
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                min: 0,
                max: double.parse(totalTime),
              ),
            ),
          ),
          Text(
            DateUtil.formatDateMs(int.parse(totalTime), format: "mm:ss"),
            style: smallWhite30TextStyle,
          ),
        ],
      ),
    );
  }
}

