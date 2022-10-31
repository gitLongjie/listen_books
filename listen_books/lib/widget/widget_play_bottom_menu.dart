import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:listen_books/model/play_songs_model.dart';

class PlayBottomMenuWidget extends StatelessWidget {
  final PlaySongsModel model;

  const PlayBottomMenuWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.sync,
              color: Color.fromARGB(255, 168, 44, 44),
            ),
            hoverColor: Colors.white70,
            onPressed: () {  },
          ),
          IconButton(
            icon: const Icon(
              Icons.first_page,
              color: Colors.white,
            ),
            onPressed: () {  },
          ),
          IconButton(
            icon: Icon(
              model.curState == PlayerState.playing ? Icons.pause_circle : Icons.play_circle,
              color: Colors.white,
            ),
            onPressed: () {  model.togglePlay();},
          ),
          IconButton(
            icon: const Icon(
              Icons.last_page,
              color: Colors.white
            ),
            onPressed: () {  },
          ),
          IconButton(
            icon: const Icon(
              Icons.list,
              color: Colors.white
            ),
            onPressed: () {  },
          ),
        ],
      ),
    );
  }
}


