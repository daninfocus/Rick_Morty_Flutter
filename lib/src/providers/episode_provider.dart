import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rick_morty/src/models/all_episodes.dart';
import 'package:rick_morty/src/models/episode.dart';

import '../../constants.dart';

class EpisodeProvider {
  Future<AllEpisodes> getAllEpisodes() async {
    try {
      var response = await get(
          Uri.parse('${Constants.baseURL}${Constants.episodeEndpoint}'));

      return AllEpisodes.fromJson(json.decode(response.body));
    } on HttpException {
      rethrow;
    }
  }

  Future<Episode> getEpisode(String url) async {
    try {
      var response = await get(Uri.parse(url));

      return Episode.fromJson(json.decode(response.body));
    } on HttpException {
      rethrow;
    }
  }
}
