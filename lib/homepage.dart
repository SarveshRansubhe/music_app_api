import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:music_app_api_interntask/api1.dart';
import 'package:music_app_api_interntask/apimanager.dart';
import 'package:music_app_api_interntask/song_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState2() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      const Center(
        child: Text("No Internet"),
      );
    });
  }
  late Future<MusicModel> _musicModel;

  @override
  void initState() {
    _musicModel = ApiManager.getMusic();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Musixmatch App"),
        centerTitle: true,
      ),
      body: FutureBuilder<MusicModel>(
          future: _musicModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.message.body.trackList.length,
                  itemBuilder: (context, index) {
                    var song_name = snapshot
                        .data!.message.body.trackList[index].track.trackName;

                    var album_name = snapshot
                        .data!.message.body.trackList[index].track.albumName;

                    var artist_name = snapshot
                        .data!.message.body.trackList[index].track.artistName;
                    var track_id = snapshot
                        .data!.message.body.trackList[index].track.trackId;
                    return Container(
                      height: 130,
                      width: 250,
                      margin: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => (SongInfo(
                                          trackId: track_id,
                                          index1: index,
                                        ))));
                              },
                              child: const Icon(
                                Icons.music_note,
                                size: 35,
                              )),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            children: [
                              Text(
                                song_name,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                album_name,
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(artist_name)
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
