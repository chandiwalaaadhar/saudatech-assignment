// To parse this JSON data, do
//
//     final charactersModel = charactersModelFromJson(jsonString);

import 'dart:convert';

CharactersModel charactersModelFromJson(String str) =>
    CharactersModel.fromJson(json.decode(str));

String charactersModelToJson(CharactersModel data) =>
    json.encode(data.toJson());

class CharactersModel {
  CharactersModel({
    this.data,
  });

  List<Datum> data;

  factory CharactersModel.fromJson(Map<String, dynamic> json) =>
      CharactersModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.name,
    this.images,
    this.gender,
    this.species,
    this.homePlanet,
    this.occupation,
    this.sayings,
    this.id,
    this.age,
    this.variables,
    this.query,
  });

  Name name;
  Images images;
  Gender gender;
  String species;
  String homePlanet;
  String occupation;
  List<String> sayings;
  int id;
  String age;
  Variables variables;
  String query;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        gender:
            json["gender"] == null ? null : genderValues.map[json["gender"]],
        species: json["species"] == null ? null : json["species"],
        homePlanet: json["homePlanet"] == null ? null : json["homePlanet"],
        occupation: json["occupation"] == null ? null : json["occupation"],
        sayings: json["sayings"] == null
            ? null
            : List<String>.from(json["sayings"].map((x) => x)),
        id: json["id"],
        age: json["age"] == null ? null : json["age"],
        variables: json["variables"] == null
            ? null
            : Variables.fromJson(json["variables"]),
        query: json["query"] == null ? null : json["query"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name.toJson(),
        "images": images == null ? null : images.toJson(),
        "gender": gender == null ? null : genderValues.reverse[gender],
        "species": species == null ? null : species,
        "homePlanet": homePlanet == null ? null : homePlanet,
        "occupation": occupation == null ? null : occupation,
        "sayings":
            sayings == null ? null : List<dynamic>.from(sayings.map((x) => x)),
        "id": id,
        "age": age == null ? null : age,
        "variables": variables == null ? null : variables.toJson(),
        "query": query == null ? null : query,
      };
}

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE});

class Images {
  Images({
    this.headShot,
    this.main,
  });

  String headShot;
  String main;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        headShot: json["head-shot"],
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "head-shot": headShot,
        "main": main,
      };
}

class Name {
  Name({
    this.first,
    this.middle,
    this.last,
  });

  String first;
  String middle;
  String last;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        first: json["first"],
        middle: json["middle"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "middle": middle,
        "last": last,
      };
}

class Variables {
  Variables();

  factory Variables.fromJson(Map<String, dynamic> json) => Variables();

  Map<String, dynamic> toJson() => {};
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
