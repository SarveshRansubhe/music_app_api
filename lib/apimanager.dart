import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app_api_interntask/api1.dart';
import 'package:music_app_api_interntask/api2.dart';

class ApiManager {
  static var client = http.Client();

  static Future<MusicModel> getMusic() async {
    var musicModel1 = null;
    try {
      Uri uri1 = Uri.parse(
          "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=123abclikethis");
      var response = await client.get(uri1);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        var musicModel2 = MusicModel.fromJson(jsonMap);

        return musicModel2;
      }
    } catch (e) {
      return musicModel1();
    }
    return musicModel1();
  }
}

class ApiManager2 {
  static var client = http.Client();

  static Future<LyricsModel> getLyrics( trackId) async {
    var musicModel1 = null;
    try {
      int track_id = trackId;
      Uri uri2 = Uri.parse(
          "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$track_id&apikey=123abclikethis");
      var response = await client.get(uri2);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        var lyricsModel2 = LyricsModel.fromJson(jsonMap);

        return lyricsModel2;
      }
    } catch (e) {
      return musicModel1();
    }
    return musicModel1();
  }
}
