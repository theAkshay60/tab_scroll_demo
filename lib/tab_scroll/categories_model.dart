// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  final List<Result>? result;

  CategoriesModel({
    this.result,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  final String? category;
  final List<String>? item;

  Result({
    this.category,
    this.item,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: json["category"],
        item: json["item"] == null
            ? []
            : List<String>.from(json["item"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "item": item == null ? [] : List<dynamic>.from(item!.map((x) => x)),
      };
}
