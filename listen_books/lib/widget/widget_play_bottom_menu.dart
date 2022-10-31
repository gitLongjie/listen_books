import 'package:flutter/material.dart';

class PlayBottomMenuWidget extends StatelessWidget {

  const PlayBottomMenuWidget({super.key});

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
              color: Colors.white,
            ),
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
            icon: const Icon(
              Icons.pause_circle,
              color: Colors.white,
            ),
            onPressed: () {  },
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


