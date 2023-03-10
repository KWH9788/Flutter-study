import 'dart:convert';

import 'package:http/http.dart';
import 'package:webtoonapp/models/webtoon_detail_model.dart';
import 'package:webtoonapp/models/webtoon_episode_model.dart';
import 'package:webtoonapp/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";
  static const String episode = "episodes";

  static Future<List<WebtoonModel>> getToday() async {
    List<WebtoonModel> webtoons = [];
    // Api GET
    final apidata = await get(Uri.parse("$baseUrl/$today"));
    // GET 성공시
    if (apidata.statusCode == 200) {
      final List<dynamic> json = jsonDecode(apidata.body);
      for (var i in json) {
        webtoons.add(WebtoonModel.fromJson(i));
      }
      return webtoons;
    }
    // GET 실패시 오류 출력
    throw Error();
  }

  static Future<WebtoonDetailModel> getDetail(String id) async {
    // API GET
    final apidata = await get(Uri.parse("$baseUrl/$id"));
    // GET 성공시
    if (apidata.statusCode == 200) {
      final dynamic json = jsonDecode(apidata.body);
      return WebtoonDetailModel.fromJson(json);
    }
    // GET 실패시 오류 출력
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getEpisode(String id) async {
    List<WebtoonEpisodeModel> episodes = [];
    // API GET
    final apidata = await get(Uri.parse("$baseUrl/$id/$episode"));
    // GET 성공시
    if (apidata.statusCode == 200) {
      final dynamic json = jsonDecode(apidata.body);
      for (var i in json) {
        episodes.add(WebtoonEpisodeModel.fromJson(i));
      }
      return episodes;
    }
    // GET 실패시 오류 출력
    throw Error();
  }
}
