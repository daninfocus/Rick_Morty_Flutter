import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rick_morty/constants.dart';
import 'package:rick_morty/src/models/all_locations.dart';

class LocationProvider {
  Future<AllLocations> getAllLocations() async {
    try {
      var response = await get(
          Uri.parse('${Constants.baseURL}${Constants.locationEndpoint}'));

      return AllLocations.fromJson(json.decode(response.body));
    } on HttpException {
      rethrow;
    }
  }
}
