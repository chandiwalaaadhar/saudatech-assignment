import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saudatechproject/models/Characters.dart';
import 'package:http/http.dart' as http;

class CharacterProvider extends ChangeNotifier {
  CharactersModel character;
  Future<CharactersModel> getCharacters() async {
    CharactersModel characters;
    var client = http.Client();
    var uri = Uri.parse('https://api.sampleapis.com/futurama/characters');
    try {
      var response = await client.get(
        uri,
      );
      if (response.statusCode == 200) {
        var jsonString = "{\"data\":${response.body}}";
        var jsonMap = json.decode(jsonString);
        characters = CharactersModel.fromJson(jsonMap);
      }
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
    return characters;
  }

  void setCharacters(CharactersModel data) {
    character = data;
  }
}
