import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rick_morty/src/models/all_characters.dart';

import '../../constants.dart';

class CharacterProvider {
  Future<AllCharacters> getAllCharacters([String page = '']) async {
    try {
      var response = await get(
          Uri.parse('${Constants.baseURL}${Constants.characterEndpoint}$page'));

      return AllCharacters.fromJson(json.decode(response.body));
    } on HttpException {
      rethrow;
    }
  }

  // Future<List<Character>> getListOfCharacters(List<int> ids) async {
  //   try {
  //     var response = await _dio
  //         .get('${Constants.baseURL}${Constants.characterEndpoint}/$ids');
  //     return List<Character>.from(
  //       response.data.map((i) => Character.fromJson(i)),
  //     );
  //   } on DioError {
  //     rethrow;
  //   }
  // }
}
