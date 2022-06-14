// To parse this JSON data, do
//
//     final boredActivity = boredActivityFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart';

BoredActivity boredActivityFromJson(String str) => BoredActivity.fromJson(json.decode(str));

class BoredActivity {
  BoredActivity({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  String activity;
  String type;
  int participants;
  double price;
  String link;
  String key;
  double accessibility;

  factory BoredActivity.fromJson(Map<String, dynamic> json) => BoredActivity(
    activity: json["activity"],
    type: json["type"],
    participants: json["participants"],
    price: json["price"].toDouble(),
    link: json["link"],
    key: json["key"],
    accessibility: json["accessibility"].toDouble(),
  );

}

class BoredService {
  Future<BoredActivity> getBoredActivity() async {
    final response = await get(Uri.parse('http://www.boredapi.com/api/activity'));
    final activity = boredActivityFromJson(response.body);
    return activity;
  }
}
