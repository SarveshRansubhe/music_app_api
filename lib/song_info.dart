import 'package:flutter/material.dart';
import 'package:music_app_api_interntask/api2.dart';

import 'api1.dart';
import 'apimanager.dart';

class SongInfo extends StatefulWidget {
  final int index1;
  final int trackId;
  const SongInfo({
    Key? key,
    required this.index1,
    required this.trackId,
  }) : super(key: key);

  @override
  State<SongInfo> createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
  late Future<MusicModel> _musicModel;
  late Future<LyricsModel> _lyricsModel;

  @override
  void initState() {
    _musicModel = ApiManager.getMusic();
    _lyricsModel = ApiManager2.getLyrics(widget.trackId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Details"),
      ),
      body: FutureBuilder<MusicModel>(
          future: _musicModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var song_name = snapshot
                  .data!.message.body.trackList[widget.index1].track.trackName;

              var album_name = snapshot
                  .data!.message.body.trackList[widget.index1].track.albumName;

              var artist_name = snapshot
                  .data!.message.body.trackList[widget.index1].track.artistName;

              var explicit = snapshot
                  .data!.message.body.trackList[widget.index1].track.explicit;

              var rating = snapshot.data!.message.body.trackList[widget.index1]
                  .track.trackRating;
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text(
                        "Track Name:",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(song_name),
                      const Text(
                        "Album Name:",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(album_name),
                      const Text(
                        "Artist Name:",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(artist_name),
                      explicit == 0
                          ? const Text(
                              "Explicit: False",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          : const Text(
                              "Explicit: True",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                      const Text(
                        "Rating:",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(rating.toString()),
                      const Text(
                        "Lyrics:",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder<LyricsModel>(
                          future: _lyricsModel,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot
                                  .data!.message.body.lyrics.lyricsBody
                                  .toString());
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
